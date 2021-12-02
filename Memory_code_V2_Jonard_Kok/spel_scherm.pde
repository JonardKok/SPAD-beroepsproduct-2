boolean voorkantKaart;
boolean achterkantKaart;
boolean opKaartGeklikt;
boolean kaartPlekkenZijnBerekend;
boolean eindebeurt;
boolean overalKlikken;
int speler;
int maxAantalSpelers;
int spelerMetBeurt = 1;
int hoevaakOpKaartGeklikt;
int kaartsoort;
int xKaart;
int yKaart;
int kaartBreedte;
int kaartHoogte;
int voorkantKaartKleur1;
int voorkantKaartKleur2;
int doodskaartofnormalekaartkleur = GROEN;
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
int[] spelerScore = {0, 0, 0, 0};
int[] kaartKleuren;
int[][] plekkenMetKaart;
int[][] kaartKleur;
int[][] kaartPlekken = {
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}
};

int[][] gekliktOpPlek = {{} };
String tekst;
String tekstGrootte;
String[] spelerNamen = {"Speler 1", "Speler 2", "Speler 3", "Speler 4"};


//tekent het hele spelscherm
void tekenSpelScherm() {
  tekenGebruikersInterface();
}

//veranderd het spelscherm als er op een kaart geklikt is.
void veranderSpelScherm() {
  kijkOpWelkeKaartGekliktIs();
  switch(hoevaakOpKaartGeklikt) {
  case 2:
    eindebeurt = true;
    klikOveral();
    break;
  case 3:
    beurtEinde();
    eindebeurt = false;
    //voorkantKaartKleur1 = ROOD;
    //voorkantKaartKleur2 = ROOD;
    hoevaakOpKaartGeklikt = 0;
    break;
  }
}

void klikOveral() {
  if (mouseX != -1 || mouseY != -1 && hoevaakOpKaartGeklikt <= 4 && eindebeurt) {
    hoevaakOpKaartGeklikt++;
    println("hoevaakOpKaartGeklikt" + hoevaakOpKaartGeklikt);
  } else {
    hoevaakOpKaartGeklikt = 0;
  }
}
void tekenGebruikersInterface() {
  tekenDoodskaartIndicator();
  tekenKaarten();
  tekenSpelers();
  if (eindebeurt) {
    tekenBeurtEindeIndicator();
  }
}

void tekenBeurtEindeIndicator() {
  text("Einde beurt", width/2, height/10);
}

//kijkt naar de kleur van de kaarten en 
void beurtEinde() {
  if (voorkantKaartKleur1 == voorkantKaartKleur2) {//hier kan een for lus gemaakt van worden
    //haalKaartUitSpel();
    switch(spelerMetBeurt) {
    case 1:
      spelerScore[0]++;
      println("spelerScore" + spelerScore[0]);
      spelerMetBeurt++;
      break;
    case 2:
      spelerScore[1]++;
      spelerMetBeurt++;
      break;
    case 3:
      spelerScore[2]++;
      spelerMetBeurt++;
      break;
    case 4:
      spelerScore[3]++;
      spelerMetBeurt++;
      break;
    }
  } else {
    spelerMetBeurt++;
  }
  if (spelerMetBeurt > getAantalSpelers()) {
    spelerMetBeurt = 1;
  }
}

void haalKaartUitSpel(int kaartnummer ) {
}

//tekent alle kaarten
void tekenKaarten() {
  kaartBreedte = width / 10;
  kaartHoogte = height / 10;
  afstandTussenKaarten = kaartBreedte / 10;
  if (!kaartPlekkenZijnBerekend) { //zorgt ervoor dat de kaartplek maar 1x berekend wordt waardoor de kaarten niet van plek veranderen. Bug voorkomen dus.
    kaartKleuren = new int[] {doodskaartofnormalekaartkleur, BLAUW, GRIJS, GEEL, ORANJE, PAARS, CYAAN, ROZE, BRUIN, DONKERROOD, DONKERBLAUW, DONKERGROEN, ZANDBRUIN, LICHT_BLAUW, WIT, BOSGROEN, CEMENTGRIJS, MIDDENVIOLETROOD, LEIGRIJS, DIEPROZE};
    hoeveelSetjesMoetenGetekendWorden();
    berekenKaartKleur();
  }
  tekenKaartenLayout();
  tekenKaartenBuitenScherm();
  tekenGeklikteKaarten();
}

void tekenKaartenBuitenScherm() {
  if (isXGekliktekaartNul()) {//fixt een bug waar de kaart linksboven in het scherm "spawnt"
    xGeklikteKaart1 = width;
    yGeklikteKaart1 = height;
    xGeklikteKaart2 = width;
    yGeklikteKaart2 = height;
  }
}

//kijkt hoeveel setjes er getekend moeten worden.
void hoeveelSetjesMoetenGetekendWorden() {
  switch(getAantalSetjes()) {
  case 12:
    plekkenMetKaart = new int[4][6];
    xCorrectie = 2; 
    yCorrectie = 1;
    break;
  case 16:
    plekkenMetKaart = new int[4][8];
    xCorrectie = 0;
    yCorrectie = 1;
    break;
  case 20:
    plekkenMetKaart = new int[5][8];
    xCorrectie = 0;
    yCorrectie = 0;
    break;
  }
}

//zoekt naar de positie van de kaart waarop geklikt is.
//Werkt niet omdat de kleuren steeds gepakt worden vanuit de i of de J dus als er eenmaal een rij getekend wordt wordt de hele rij zo.
void kijkOpWelkeKaartGekliktIs() { 
  for (int i = 0; i < (plekkenMetKaart.length); i++) {
    for (int j = 0; j < (plekkenMetKaart[i].length); j++) {
      voorkantKaartPlekBerekenen(i, j);
      if (opKaartGeklikt(xKaart, yKaart, kaartBreedte, kaartHoogte)) {
        hoevaakOpKaartGeklikt += 1;
        //println("opKaartGeklikt  " + hoevaakOpKaartGeklikt);
        switch(hoevaakOpKaartGeklikt) {
        case 1:
          geefKaartPlekDoor(xKaart, yKaart);
          println("kleur " + kaartKleur[i][j], "kaartplek " + plekkenMetKaart[i].length, j, i);
          voorkantKaartKleur1 = kaartKleuren[kaartKleur[i][j]];
          break;
        case 2:
          geefKaartPlekDoor(xKaart, yKaart);
          voorkantKaartKleur2 = kaartKleuren[kaartKleur[i][j]];
          break;
        }
      }
    }
  }
}

void voorkantKaartPlekBerekenen(int i, int j) {
  xKaart = kaartBreedte + kaartBreedte * j + afstandTussenKaarten * j;
  yKaart = kaartHoogte * 2 + kaartHoogte * i + afstandTussenKaarten * i;
}

void geefKaartPlekDoor(int x, int y) {
  kaart++;
  switch (kaart) {
  case 1:
    xGeklikteKaart1 = x;
    yGeklikteKaart1 = y;
    break;
  case 2:
    xGeklikteKaart2 = x;
    yGeklikteKaart2 = y;
    kaart = 0;
    break;
  }
}

// tekent de kaart(en) die omgedraaid zijn.
void tekenGeklikteKaarten() {
  tekenKaart(xGeklikteKaart1, yGeklikteKaart1, kaartBreedte, kaartHoogte, voorkantKaartKleur1);
  tekenKaart(xGeklikteKaart2, yGeklikteKaart2, kaartBreedte, kaartHoogte, voorkantKaartKleur2);
}

//DIT BEREKENT DE KLEUREN________________________________________________________________________________________
void berekenKaartKleur() {
  kaartKleur = new int[plekkenMetKaart.length][plekkenMetKaart[0].length];
  for (int i = 0; i < kaartKleur.length; i++) {
    for (int j = 0; j < kaartKleur[i].length; j++) {
      kaartKleur[i][j] = int(random(1, (aantalSetjes) + 1));
      kaartKleur[i][j] = kaartKleur[i][j] - 1;
      int kleurFrequentie = 0;
      for (int k = 0; k < kaartKleur.length; k++) {
        for (int l = 0; l < kaartKleur[k].length; l++) {//gaat de hele rij af om te kijken of de kleur al 2x bestaat.
          if (kaartKleur[k][l] == kaartKleur[i][j]) {
            kleurFrequentie++;
            if (kleurFrequentie > 2 && j > 0) {
              j--;
              kleurFrequentie = 0;
            }
          }
        }
      }
    }  
    for (int j = 0; j < kaartKleur[i].length; j++) {
      println(i, j, "kleurkaart "+kaartKleur[i][j] ); //Printen van de kleuren voor debuggen
    }
  }
  kaartPlekkenZijnBerekend = true;
}

//tekent de grid van kaarten zonder kleur._______________________________________________________________________
void tekenKaartenLayout() {
  for (int i = 0; i < (kaartPlekken.length - yCorrectie); i++) {
    for (int j = 0; j < (kaartPlekken[i].length  - xCorrectie); j++) {//tekent de rij
      xKaart = kaartBreedte + kaartBreedte * j + afstandTussenKaarten * j;
      yKaart = kaartHoogte * 2 + kaartHoogte * i + afstandTussenKaarten * i;
      //tekenKaart(xKaart, yKaart, kaartBreedte, kaartHoogte, ROOD); ORIGINEEL
      tekenKaart(xKaart, yKaart, kaartBreedte, kaartHoogte, kaartKleuren[kaartKleur[i][j]]); //test
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
    doodskaartofnormalekaartkleur = ROOD;
    tekenDoodskaartOptie("Doodskaarten AAN", ROOD, "klein");
  } else if (!getDoodskaarten()) {
    doodskaartofnormalekaartkleur = GROEN;
    tekenDoodskaartOptie("Doodskaarten UIT", GROEN, "klein");
  }
}

//tekent de tekst die aangeeft of doodskaarten aan staan of niet
void tekenDoodskaartOptie(String tekst, int kleur, String tekstGrootte) {
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
    if (i == spelerMetBeurt - 1) {
      tekenSpelerNamen(spelerNamen, spelerScore, i, xSpelerText, ySpelerText, ROOD);
    } else {
      tekenSpelerNamen(spelerNamen, spelerScore, i, xSpelerText, ySpelerText, GEEL);
    }
    if (speler >= maxAantalSpelers) {
      speler = 0;
    }
  }
}

//text(spelerNamen[i] + " Score : " + spelerScore[i], xSpelerText, );

void tekenSpelerNamen(String spelernaam[], int spelerScore[], int i, int x, int y, int kleur) {
  fill(kleur);
  text(spelernaam[i] + " Score : " + spelerScore[i], x, y + y * i);
}

//integer die het aantal setjes van het startscherm pakt.
int getAantalSetjes() {
  return aantalSetjes;
}

//integer die het aantal spelers van het startscherm pakt.
int getAantalSpelers() {
  return aantalSpelers;
}

boolean isSpelerIndicatorTeVer(int y) {
  return y >= (getTekstgrootte("klein") * getAantalSpelers());
}

boolean isXGekliktekaartNul() {
  return(xGeklikteKaart1 | xGeklikteKaart2 | yGeklikteKaart1 | yGeklikteKaart2) == 0;
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
boolean opKaartGeklikt(int x, int y, int breedte, int hoogte) {
  return mouseX > x && mouseX < x + breedte && mouseY > y && mouseY < y + hoogte && spelscherm();
}
