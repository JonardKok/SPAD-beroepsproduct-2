//Kleuren
final int WIT = #FFFFFF;
final int PAARSACHTIG = #7B68EE;
final int ROOD = #FF0000;
final int GROEN = #00FF00;
final int BLAUW = #0000FF;
final int GRIJS = #AAAAAA;
final int GEEL = #FFFF00;
final int ORANJE = #FFA500;
final int PAARS = #800080;
final int CYAAN = #00FFFF;
final int ROZE = #FFC0CB;
final int BRUIN = #654321;
final int DONKERROOD = #8B0000;
final int DONKERBLAUW = #00007B;
final int DONKERGROEN = #008B00;
final int ZANDBRUIN = #F4A460;
final int LICHT_BLAUW = #ADD8E6;
final int GEELGROEN = #9ACD32;
final int TARWE = #F5DEB3;
final int MIDDENVIOLETROOD= #C71585;
final int LEIGRIJS = #708090;
final int DIEPROZE= #FF1493;
boolean kaartPlekkenZijnBerekend;
boolean eindebeurt;
boolean puntGekregen;
boolean doodskaartGeklikt;
boolean kaartGevonden;
int xSpelerText;
int ySpelerText;
int doodskaartGekliktVolgorde;
int doodskaartWeg = 0;
int setjeWeg = 0;
int maxAantalSpelers = 4;
int spelerMetBeurt = 0;
int hoevaakOpKaartGeklikt = 0;
int xKaartGeklikt;
int yKaartGeklikt;
int xKaart;
int yKaart;
int kolomKaart1;
int rijKaart1;
int kolomKaart2;
int rijKaart2;
int kaartBreedte;
int kaartHoogte;
int voorkantKaartKleur1;
int voorkantKaartKleur2;
int doodskaartOfNormaleKaartKleur = GROEN;
int afstandTussenKaarten;
int kaart = 0;
int xCorrectie = 0;
int yCorrectie = 0;
int xGeklikteKaart1;
int yGeklikteKaart1;
int xGeklikteKaart2;
int yGeklikteKaart2;
int[] spelerScore = {0, 0, 0, 0};
int[] kaartKleuren;
int[][] plekkenMetKaart;
int[][] kaartKleur;
int[][] geklikteKaarten = {
  {WIT, WIT, WIT, WIT, WIT, WIT, WIT, WIT}, 
  {WIT, WIT, WIT, WIT, WIT, WIT, WIT, WIT}, 
  {WIT, WIT, WIT, WIT, WIT, WIT, WIT, WIT}, 
  {WIT, WIT, WIT, WIT, WIT, WIT, WIT, WIT}, 
  {WIT, WIT, WIT, WIT, WIT, WIT, WIT, WIT}, 
};

int[][] kaartPlekken = {
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {0, 1, 2, 3, 4, 5, 6, 7}
};
String[] spelerNamen = {"Speler 1", "Speler 2", "Speler 3", "Speler 4"};

void tekenSpelScherm() {
  tekenDoodskaartIndicator();
  tekenKaarten();
  tekenSpelers();
  if (eindebeurt) {
    tekenBeurtEindeIndicator();
  }
}


//tekent de doodskaarten
void tekenDoodskaartIndicator() {
  if (getDoodskaarten()) {
    doodskaartOfNormaleKaartKleur = ROOD;
    tekenDoodskaartOptie("Doodskaarten AAN", ROOD, "klein");
  } else if (!getDoodskaarten()) {
    doodskaartOfNormaleKaartKleur = GROEN;
    tekenDoodskaartOptie("Doodskaarten UIT", GROEN, "klein");
  }
}

//boolean die van het startscherm de status van doodskaarten pakt zodat je weet welke er wel en niet zijn.
boolean getDoodskaarten() {
  return doodsKaarten;
}

//tekent de tekst die aangeeft of doodskaarten aan staan of niet
void tekenDoodskaartOptie(String tekst, int kleur, String tekstGrootte) {
  fill(kleur);
  textSize(getTekstgrootte(tekstGrootte));
  text(tekst, width - int(textWidth(tekst)), getTekstgrootte(tekstGrootte));
}

//tekent alle kaarten
void tekenKaarten() {
  kaartBreedte = width / 10;
  kaartHoogte = height / 10;
  afstandTussenKaarten = kaartBreedte / 10;
  if (!kaartPlekkenZijnBerekend) { //zorgt ervoor dat de kaartplek maar 1x berekend wordt waardoor de kaarten niet van plek veranderen. Bug voorkomen dus.
    kaartKleuren = new int[] {doodskaartOfNormaleKaartKleur, BLAUW, GRIJS, GEEL, ORANJE, PAARS, CYAAN, ROZE, BRUIN, DONKERROOD, DONKERBLAUW, DONKERGROEN, ZANDBRUIN, LICHT_BLAUW, PAARSACHTIG, GEELGROEN, TARWE, MIDDENVIOLETROOD, LEIGRIJS, DIEPROZE};
    hoeveelSetjesMoetenGetekendWorden();
    genereerKleuren();
    printKleuren();
  }
  tekenKaartenLayout();
  if (hoevaakOpKaartGeklikt != 0) {
    tekenGeklikteKaarten();
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

void genereerKleuren() {
  kaartKleur = new int[plekkenMetKaart.length][plekkenMetKaart[0].length];
  vulArrayMetTijdelijkCijfer();
  for (int hoeveelheidSetjes = 0; hoeveelheidSetjes < (kaartKleur.length*kaartKleur[0].length)/2; hoeveelheidSetjes++ ) {
    berekenKaartKleur(2, hoeveelheidSetjes);
  }
  kaartPlekkenZijnBerekend = true;
}

void vulArrayMetTijdelijkCijfer() {
  for (int kolom = 0; kolom < kaartKleur.length; kolom++) {
    for (int rij = 0; rij < kaartKleur[kolom].length; rij++) {
      kaartKleur[kolom][rij] = 30;
    }
  }
}

//DIT BEREKENT DE KLEUREN________________________________________________________________________________________
void berekenKaartKleur(int aantalItems, int kleurNr) {
  for (int kleurfrequentie = 0; kleurfrequentie < aantalItems; ) {
    int rij = round(random(0, kaartKleur[0].length-1));
    int kolom = round(random(0, kaartKleur.length-1));
    if (kaartKleur[kolom][rij] == 30) {
      kaartKleur[kolom][rij] = kleurNr;
      kleurfrequentie += 1;
    }
  }
}

//print de kleuren in de console #TESTMETHODE
void printKleuren() {
  for (int kolom = 0; kolom < kaartKleur.length; kolom++) {
    for (int rij = 0; rij < kaartKleur[kolom].length; rij++) {
      println(kolom, rij, "kleurkaart "+kaartKleur[kolom][rij] ); //Printen van de kleuren voor debuggen
    }
  }
}

// tekent de kaart(en) die omgedraaid zijn.
void tekenGeklikteKaarten() {
  tekenKaart(xGeklikteKaart1, yGeklikteKaart1, kaartBreedte, kaartHoogte, voorkantKaartKleur1);
  tekenKaart(xGeklikteKaart2, yGeklikteKaart2, kaartBreedte, kaartHoogte, voorkantKaartKleur2);
}

//tekent de grid van kaarten met de achterkant van de kaart-kleur.
void tekenKaartenLayout() {
  for (int i = 0; i < (kaartPlekken.length - yCorrectie); i++) {
    for (int j = 0; j < (kaartPlekken[i].length  - xCorrectie); j++) {
      xKaart = kaartBreedte + kaartBreedte * j + afstandTussenKaarten * j;
      yKaart = kaartHoogte * 2 + kaartHoogte * i + afstandTussenKaarten * i;
      tekenKaart(xKaart, yKaart, kaartBreedte, kaartHoogte, geklikteKaarten[i][j]);
    }
  }
}

//tekent de kaart.
void tekenKaart(int x, int y, int breedte, int hoogte, int kaartKleur) {
  fill(kaartKleur);
  rect(x, y, breedte, hoogte, 20);
}

//tekent de spelers
void tekenSpelers() {
  maxAantalSpelers = getAantalSpelers();
  xSpelerText = getTekstgrootte("klein");
  ySpelerText = xSpelerText;
  for (int i = 0; i < maxAantalSpelers; i++) {
    textSize(getTekstgrootte("klein"));
    if (i == spelerMetBeurt) {
      tekenSpelerNamen(spelerNamen[i], spelerScore, i, xSpelerText, ySpelerText, ROOD);
    } else {
      tekenSpelerNamen(spelerNamen[i], spelerScore, i, xSpelerText, ySpelerText, GEEL);
    }
  }
}

//integer die de tekstgroottes van het startscherm pakt.
int getTekstgrootte(String tekst) {
  if (tekst == "klein") {
    return kleineTekstGrootte;
  } else if (tekst == "normaal") {
    return normaleTekstGrootte;
  } else if (tekst == "groot") {
    return groteTekstGrootte;
  } 
  return normaleTekstGrootte;
}

void tekenSpelerNamen(String spelernaam, int spelerScore[], int i, int x, int y, int kleur) {
  fill(kleur);
  text(spelernaam + " Score : " + spelerScore[i], x, y + y * i);
}

void tekenBeurtEindeIndicator() {
  text("Einde beurt", width/2, height/10);
}

//veranderd het spelscherm als er op een kaart geklikt is.
void kaartKlikActies() {
  geefKaartKleurDoor();
  switch(hoevaakOpKaartGeklikt) {
  case 2:
    eindebeurt = true;
    klikOveral();
    break;
  case 3:
    beurtEinde();
    gekozenKaartVerbergen();
    hoevaakOpKaartGeklikt = 0;
    doodskaartGeklikt = false;
    eindebeurt = false;
    break;
  }
}  

//zoekt naar de positie van de kaart waarop geklikt is
void geefKaartKleurDoor() {
  kaartGevonden = false;
  for (int kolom = 0; kolom < plekkenMetKaart.length /*&& !kaartGevonden*/; kolom++) {
    for (int rij = 0; rij < plekkenMetKaart[kolom].length /*&& !kaartGevonden*/; rij++) {
      voorkantKaartPlekBerekenen(kolom, rij);
      if (opKaartGeklikt(xKaartGeklikt, yKaartGeklikt, kaartBreedte, kaartHoogte, geklikteKaarten[kolom][rij])) {
        kaartGevonden = true;
        hoevaakOpKaartGeklikt += 1;
        switch(hoevaakOpKaartGeklikt) {
        case 1:
          voorkantKaartKleur1 = kaartKleuren[kaartKleur[kolom][rij]];
          if (opDoodskaartGeklikt(kolom, rij)) {
            doodskaartKlik(1, kolom, rij);
            geefKaartInfoDoor(kolom, rij);
          } else {
            geefKaartInfoDoor(kolom, rij);
          }
          break;
        case 2:
          if (opDoodskaartGeklikt(kolom, rij)) {
            doodskaartKlik(2, kolom, rij);
          } else {
            geefKaartInfoDoor(kolom, rij);
            voorkantKaartKleur2 = kaartKleuren[kaartKleur[kolom][rij]];
          }
          break;
        }
      }
    }
  }
}

void voorkantKaartPlekBerekenen(int kolom, int rij) {
  xKaartGeklikt = kaartBreedte + kaartBreedte * rij + afstandTussenKaarten * rij;
  yKaartGeklikt = kaartHoogte * 2 + kaartHoogte * kolom + afstandTussenKaarten * kolom;
}

//boolean die kijkt of er op een kaart geklikt is.
boolean opKaartGeklikt(int x, int y, int breedte, int hoogte, int kleur) {
  return mouseX > x && mouseX < x + breedte && mouseY > y && mouseY < y + hoogte && spelscherm() && !eindebeurt && kleur !=0;
}

boolean spelscherm() {
  return scherm == SPEL_SCHERM;
}

boolean opDoodskaartGeklikt(int kolom, int rij) {
  return kaartKleuren[kaartKleur[kolom][rij]] == doodskaartOfNormaleKaartKleur && getDoodskaarten();
}

void doodskaartKlik(int doodskaartNr, int kolom, int rij) {
  geefKaartInfoDoor(kolom, rij);
  doodskaartGekliktVolgorde = doodskaartNr;
  voorkantKaartKleur2 = ROOD;
  doodskaartGeklikt = true;
  hoevaakOpKaartGeklikt = 2;
}

void geefKaartInfoDoor(int kolom, int rij) {
  kaart++;
  switch (kaart) {
  case 1:
    xGeklikteKaart1 = xKaartGeklikt;
    yGeklikteKaart1 = yKaartGeklikt;
    kolomKaart1 = kolom;
    rijKaart1 = rij;
    break;
  case 2:
    xGeklikteKaart2 = xKaartGeklikt;
    yGeklikteKaart2 = yKaartGeklikt;
    kolomKaart2 = kolom;
    rijKaart2 = rij;
    kaart = 0;
    break;
  }
}

void klikOveral() {
  if (hoevaakOpKaartGeklikt <= 4 && eindebeurt) {
    hoevaakOpKaartGeklikt++;
  } else {
    hoevaakOpKaartGeklikt = 0;
  }
}

//Geeft de speler punten als er punten gegeven kunnen worden en gaat geeft dan de volgende speler de beurt.
void beurtEinde() {
  if (kanPuntGegevenWorden()) {
    spelerScore[spelerMetBeurt]++;
    puntGekregen = true;
    setjeWeg++;
    println("setjeWeg3", setjeWeg);
    spelerMetBeurt++;
  } else if (doodskaartGeklikt) {//HIER ZIT EEN FOUT SETJEWEG WORDT 3
    spelerScore[spelerMetBeurt]--;
    doodskaartWeg++;
    println("doodskaartWeg");
    println("setjeWeg1", setjeWeg);
    if (doodskaartWeg >= 2) {
      doodskaartWeg = 0;
      setjeWeg++;
      println("setjeWeg2", setjeWeg);
    }
  } else {
    puntGekregen = false;
    spelerMetBeurt++;
    xGeklikteKaart2 = width;
    yGeklikteKaart2 = height;
  }
  resetSpelerBeurt();
  zijnKaartenWeg();
}

boolean kanPuntGegevenWorden() {//voorkomt een bug die ervoor zorgt dat je niet 2x op dezelfde kaart kan klikken voor een punt.
  if ((xGeklikteKaart1 == xGeklikteKaart2) && (yGeklikteKaart1 == yGeklikteKaart2 && doodskaartGeklikt)) {
    return false;
  } else if (voorkantKaartKleur1 == voorkantKaartKleur2 && ((xGeklikteKaart1 != xGeklikteKaart2) || (yGeklikteKaart1 != yGeklikteKaart2)) && !doodskaartGeklikt) {
    return true;
  }
  return false;
}

void resetSpelerBeurt() {
  if (spelerMetBeurt > getAantalSpelers()-1) {
    spelerMetBeurt = 0;
  }
}


int getAantalSpelers() { //integer die het aantal spelers van het startscherm pakt.
  return aantalSpelers;
}

void zijnKaartenWeg() {
  if (setjeWeg == getAantalSetjes() || (setjeWeg == getAantalSetjes() && doodskaartWeg !=2 && getDoodskaarten())) {
    scherm = EIND_SCHERM;
  }
}

int getAantalSetjes() { //methode die het aantal setjes .
  return aantalSetjes;
}

void gekozenKaartVerbergen() {
  if (puntGekregen) {
    geklikteKaarten[kolomKaart1][rijKaart1] = 0;
    geklikteKaarten[kolomKaart2][rijKaart2] = 0;
    voorkantKaartKleur1 = 0;
    voorkantKaartKleur2 = 0;
  } else if (doodskaartGeklikt) {
    if (doodskaartGekliktVolgorde == 1) {
      geklikteKaarten[kolomKaart1][rijKaart1] = 0;
      geklikteKaarten[kolomKaart2][rijKaart2] = 0;
      voorkantKaartKleur1 = 0;
      voorkantKaartKleur2 = 0;
    } else if (doodskaartGekliktVolgorde == 2) {
      geklikteKaarten[kolomKaart2][rijKaart2] = 0;
      voorkantKaartKleur1 = WIT;
      voorkantKaartKleur2 = 0;
    }
  } else {
    voorkantKaartKleur1 = WIT;
    voorkantKaartKleur2 = WIT;
  }
}
