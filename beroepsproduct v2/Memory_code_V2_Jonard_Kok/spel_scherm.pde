boolean voorkantKaart;
boolean achterkantKaart;
boolean opKaartGeklikt;
boolean kaartPlekkenZijnBerekend;
int speler;
int maxAantalSpelers;
int spelerScore;
int spelerMetBeurt;
int hoevaakOpKaartGeklikt;
int kaartsoort;
int xKaart;
int yKaart;
int kaartBreedte;
int kaartHoogte;
int tussenKaartGrootte;
int voorkantKaartKleur1;
int voorkantKaartKleur2;
int doodskaartofnormalekaartkleur;
int afstandTussenKaarten;
int kaart = 0;
int xCorrectie = 0;
int yCorrectie = 0;
int voorkantKleurKaart;
int xGeklikteKaart1;
int yGeklikteKaart1;
int xGeklikteKaart2;
int yGeklikteKaart2;
int puntspeler1;
int puntspeler2;
int puntspeler3;
int puntspeler4;
int[] kleurKaart;
int[] kaartKleuren = {doodskaartofnormalekaartkleur, BLAUW, GRIJS, GEEL, ORANJE, PAARS, CYAAN, ROZE, BRUIN, DONKERROOD, DONKERBLAUW, DONKERGROEN, ZANDBRUIN, LICHT_BLAUW, WIT, BOSGROEN, CEMENTGRIJS, MIDDENVIOLETROOD, LEIGRIJS, DIEPROZE};
int[][] plekkenMetKaartGetekend;
int[][] kaartPlekken = {
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}
};

int[][] gekliktOpPlek = {{}};
String tekst;
String tekstGrootte;
String[] tekenSpelerNamen = {"Speler 1", "Speler 2", "Speler 3", "Speler 4"};


//tekent het hele spelscherm
void tekenSpelScherm() {
  tekenGebruikersInterface();
}

//veranderd het spelscherm als er op een kaart geklikt is.
void veranderSpelScherm() {
  kijkOpWelkeKaartGekliktIs();
  if (hoevaakOpKaartGeklikt >= 2) {
    stopBeurt();
    geefVolgendeSpelerDeBeurt();
    hoevaakOpKaartGeklikt = 0;
  }
}

void tekenGebruikersInterface() {
  tekenDoodskaartIndicator();
  tekenKaarten();
  tekenSpelers();
}

void stopBeurt() {
  if (voorkantKaartKleur1 == voorkantKaartKleur2) {
    switch (spelerMetBeurt) {
    case 1:
      puntspeler1++;
    case 2:
      puntspeler2++;
    case 3:
      puntspeler3++;
    case 4:
      puntspeler4++;
    }
  } else {
    spelerMetBeurt++;
  }
}

//tekent alle kaarten
void tekenKaarten() {
  kaartBreedte = width / 10;
  kaartHoogte = height / 10;
  afstandTussenKaarten = kaartBreedte / 10;
  if (!kaartPlekkenZijnBerekend) { //zorgt ervoor dat de kaartplek maar 1x berekend wordt waardoor de kaarten niet van plek veranderen. Bug voorkomen dus.
    berekenKaartPlek();
  }
  hoeveelSetjesMoetenGetekendWorden();
  tekenKaartenLayout();
  tekenGeklikteKaartenBuitenScherm();
  tekenGeklikteKaarten();
}

//methode maken die de geplaatste plek van een kleur de kleur maakt.
/*
 als dingen gerenderd zijn dan
 en als er op een kaart is geklikt dan
 teken de kleur van de kaart
 als de kleur van de kaart gelijk is aan de kleur van de kaart die daarvoor aangeklikt is 
 speler krijgt een punt erbij
 anders gaat de beurt naar de volgende speler
 */
void tekenGeklikteKaartenBuitenScherm() {
  if (isXGekliktekaartNul()) {
    xGeklikteKaart1 = width;
    yGeklikteKaart1 = height;
    xGeklikteKaart2 = width;
    yGeklikteKaart2 = height;
  }
}

//kijkt hoeveel setjes er getekend moeten worden.
void hoeveelSetjesMoetenGetekendWorden() {
  switch (getAantalSetjes()) {
  case 12:
    plekkenMetKaartGetekend = new int [4][6];
    xCorrectie = 2; 
    yCorrectie = 1;
    break;
  case 16:
    plekkenMetKaartGetekend = new int [4][8];
    xCorrectie = 0;
    yCorrectie = 1;
    break;
  case 20:
    plekkenMetKaartGetekend = new int [5][8];
    xCorrectie = 0;
    yCorrectie = 0;
    break;
  }
}

//zoekt naar de positie van de kaart waarop geklikt is.
void kijkOpWelkeKaartGekliktIs() { 
  for (int i = 0; i < (plekkenMetKaartGetekend.length); i++) {
    for (int j = 0; j < (plekkenMetKaartGetekend[i].length); j++) {
      voorkantKaartPlekBerekenen(i, j);
      if (opKaartGeklikt(xKaart, yKaart, kaartBreedte, kaartHoogte)) {
        hoevaakOpKaartGeklikt++;
        switch (hoevaakOpKaartGeklikt) {
        case 0:
          geefKaartPlekDoor(xKaart, yKaart);
          println("kleur " + kleurKaart[j], "kaartplek " + plekkenMetKaartGetekend[i].length, j, i);
          voorkantKaartKleur1 = kaartKleuren[kleurKaart[i]];
          break;
        case 1:
          geefKaartPlekDoor(xKaart, yKaart);
          voorkantKaartKleur2 = kaartKleuren[kleurKaart[i]];
          break;
        }
      }
    }
  }
}

void voorkantKaartPlekBerekenen(int i, int j) {
  xKaart = kaartBreedte + kaartBreedte * j + afstandTussenKaarten * j;
  yKaart = kaartHoogte * 2 + kaartHoogte * i + afstandTussenKaarten * i;
  tussenKaartGrootte = width/100;
}

void geefKaartPlekDoor(int x, int y) {
  kaart++;
  if (kaart == 1) {
    xGeklikteKaart1 = x;
    yGeklikteKaart1 = y;
  } else if (kaart == 2) {
    xGeklikteKaart2 = x;
    yGeklikteKaart2 = y;
    kaart = 0;
  }
}

// tekent de kaart(en) die omgedraaid zijn.
void tekenGeklikteKaarten() {
  tekenKaart(xGeklikteKaart1, yGeklikteKaart1, kaartBreedte, kaartHoogte, voorkantKaartKleur1);
  tekenKaart(xGeklikteKaart2, yGeklikteKaart2, kaartBreedte, kaartHoogte, voorkantKaartKleur2);
}

//DIT BEREKEND DE KLEUREN________________________________________________________________________________________
//Tekent de kaart met kleur
void berekenKaartPlek() {
  kleurKaart = new int[getAantalSetjes()];
  for (int i = 0; i < kleurKaart.length; i++) {
    kleurKaart[i] = int(random(1, (kleurKaart.length/2) + 1));
    int cijferFrequentie = 0;
    for (int j = 0; j < kleurKaart.length; j++) {
      if (kleurKaart[i] != 0 && kleurKaart[j]==kleurKaart[i]) {
        cijferFrequentie++;
      }
      if (komtCijferVakerVoor(cijferFrequentie, i)) {
        i--;
        cijferFrequentie = 0;
      }
    }
  }
  println(kleurKaart);
  kaartPlekkenZijnBerekend = true;
}

//tekent de grid van kaarten zonder kleur.
void tekenKaartenLayout() {
  for (int i = 0; i < (kaartPlekken.length - yCorrectie); i++) {
    for (int j = 0; j < (kaartPlekken[i].length  - xCorrectie); j++) {
      xKaart = kaartBreedte + kaartBreedte * j + afstandTussenKaarten * j;
      yKaart = kaartHoogte * 2 + kaartHoogte * i + afstandTussenKaarten * i;
      tussenKaartGrootte = width/100;
      tekenKaart(xKaart, yKaart, kaartBreedte, kaartHoogte, ROOD);
    }
  }
}

//tekent de kaart.
void tekenKaart(int x, int y, int breedte, int hoogte, int kleur) {
  fill(WIT);
  rect(x, y, breedte, hoogte, 20);
  tekenKleurVanKaart(x, y, breedte, hoogte, kleur);
}
//tekent de kleur van de kaart.
void tekenKleurVanKaart(int x, int y, int breedte, int hoogte, int kleur) {
  breedte = breedte / 4;
  hoogte = hoogte / 4;
  x = x + breedte * 2;
  y = y + hoogte * 2;
  fill(kleur);
  rect(x, y, breedte, hoogte);
}

//tekent de doodskaarten
void tekenDoodskaartIndicator() {
  if (getDoodskaarten()) {
    tekenDoodskaartOptie("Doodskaarten AAN", ROOD, "klein");
  } else if (!getDoodskaarten()) {
    tekenDoodskaartOptie("Doodskaarten UIT", GROEN, "klein");
  }
}

//tekent de tekst die aangeeft of doodskaarten aan staan of niet
void tekenDoodskaartOptie(String tekst, int kleur, String tekstGrootte) {
  doodskaartofnormalekaartkleur = kleur;
  fill(kleur);
  textSize(getTekstgrootte(tekstGrootte));
  text(tekst, width - int(textWidth(tekst)), getTekstgrootte(tekstGrootte));
}

//tekent de spelers
void tekenSpelers() {
  maxAantalSpelers = getAantalSpelers();
  int xSpelerText = getTekstgrootte("klein");
  int ySpelerText = xSpelerText;
  for (int i = 0; i < maxAantalSpelers; i++) {
    speler++;
    textSize(getTekstgrootte("klein"));
    fill(GEEL);
    text(tekenSpelerNamen[i] + " Score:" + spelerScore, xSpelerText, ySpelerText + ySpelerText * i);
    tekenHuidigeSpelerIndicator(tekenSpelerNamen[i], xSpelerText, ySpelerText, spelerMetBeurt);
    if (speler >= maxAantalSpelers) {
      speler = 0;
    }
  }
}

void tekenHuidigeSpelerIndicator(String tekst, int x, int y, int welkeSpeler) {
  knopTextBreedte = int(textWidth(tekst)) * 2;
  y = (y - getTekstgrootte("klein") / 2) * welkeSpeler;
  x = x + knopTextBreedte;
  int breedte = width/100;
  int hoogte = height/90;
  fill(ROOD);
  rect(x, y, breedte, hoogte);
  if (isSpelerIndicatorTeVer(y)){
    y = getTekstgrootte("klein");
  }
}

void geefVolgendeSpelerDeBeurt() {
  spelerMetBeurt++;
}


//integer die het aantal setjes van het startscherm pakt.
int getAantalSetjes() {
  return aantalSetjes;
}

//integer die het aantal spelers van het startscherm pakt.
int getAantalSpelers() {
  return aantalSpelers;
}

boolean isSpelerIndicatorTeVer(int y){
  return y >= (getTekstgrootte("klein") * getAantalSpelers());
}

boolean isXGekliktekaartNul() {
  return (xGeklikteKaart1 | xGeklikteKaart2 | yGeklikteKaart1 | yGeklikteKaart2) == 0;
} 

boolean spelscherm() {
  return scherm == SPEL_SCHERM;
}

//integer die de tekstgroottes van het startscherm pakt.
int getTekstgrootte(String tekst) {
  if (tekst == "klein") {
    return kleineTekstGrootte;
  } else if (tekst == "normaal") {
    return normaleTekstGrootte;
  } else if (tekst == "groot") {
    return groteTekstGrootte;
  } //hier zou normaal een else staan, maar omdat er onder de if statements een return staat hoeft dat niet. 
  println("Tekstgrootte is verkeerd getypt, normaal wordt gebruikt");
  return normaleTekstGrootte;
}

//boolean die van het startscherm de status van doodskaarten pakt zodat je weet welke er wel en niet zijn.
boolean getDoodskaarten() {
  return doodsKaarten;
}

//boolean die kijkt of een cijfer vaker voor komt, zodat je geen dubbele setjes krijgt.
boolean komtCijferVakerVoor(int cijferFrequentie, int i) {
  return cijferFrequentie > 2 && i > 0;
}

//boolean die kijkt of er op een kaart geklikt is.
boolean opKaartGeklikt (int x, int y, int breedte, int hoogte) {
  return mouseX > x && mouseX < x + breedte && mouseY > y && mouseY < y + hoogte && spelscherm();
}
