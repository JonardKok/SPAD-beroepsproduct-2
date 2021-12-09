int eindSchermTekstGrootte;
int xScores;
int yScores;
int xKnop;
int yKnop;
int xText;
int yText;
int eindSchermKnopBreedte;
int eindSchermKnopHoogte;
String[] knopNaam = {"menu", "opnieuw", "stoppen"};
String[][] eindschermKnopOpties = {
  {"Ga naar", "het menu"}, 
  {"Speel het", "spel", "opnieuw"}, 
  {"Stop met", "spelen"}
};

void tekenEindScherm() {
  aantalSpelers = getSpelers();
  tekenScores();
  tekenKnoppen();
}

int getSpelers() {
  return aantalSpelers;
}

void tekenScores() {
  berekenPlekken();
  textSize(eindSchermTekstGrootte);
  fill(getKleur("GEEL"));
  text("Scores", xScores, yScores);
  for (int i = 0; i < getSpelers(); i++) {
    tekenSpelerMetScore(getScore(i), i, xScores, yScores, eindSchermTekstGrootte);
  }
}

void berekenPlekken() {
  eindSchermTekstGrootte = getTekstGroottes("normaal");
  xScores = width/100;
  yScores = eindSchermTekstGrootte;
}

int getKleur(String kleurNaam) {
  if (kleurNaam == "GEEL") {
    return GEEL;
  }
  return 255;
}

int getScore(int i) {
  return spelerScore[i];
}

void tekenSpelerMetScore(int spelerScore, int i, int x, int y, int rijVerschil) {
  text("Speler "+ (i+1) + " eindscore: " + spelerScore, x, y + rijVerschil + rijVerschil * i);
}

void eindSchermActies() {
  knopActie(zoekKnop());
}

String zoekKnop() {
  for (int knop = 0; knop < knopNaam.length; knop++) {
    xKnop = eindSchermKnopBreedte * knop;
    yKnop = height / 2;
    if (opEindschermKnopGedrukt (xKnop, yKnop, eindSchermKnopBreedte, eindSchermKnopHoogte)) {
      return knopNaam[knop];
    }
  }
  return "geen_knop";
}

boolean opEindschermKnopGedrukt (int x, int y, int breedte, int hoogte) {
  return mouseX > x && mouseX < x + breedte && mouseY > y && mouseY < y + hoogte && eindscherm();
}

boolean eindscherm() {//komt uit bug squash
  return scherm == EIND_SCHERM;
}

void knopActie(String knop) {
  switch (knop) {
  case "menu":
    setMenuResetVariabelen();
    scherm = START_SCHERM;
    break;
  case "opnieuw":
    setSpelResetVariabelen();
    scherm = SPEL_SCHERM;
    break;
  case "stoppen":
    exit();
    break;
  }
}

void setMenuResetVariabelen() {
  setSpelResetVariabelen();
  aantalSetjes = 12;
  aantalSpelers = 1;
  jaOfNee = "nee";
}

void setSpelResetVariabelen() {
  kaartPlekkenZijnBerekend = false;
  eindebeurt = false;
  puntGekregen = false;
  doodskaartGeklikt = false;
  kaartGevonden = false;
  doodskaartWeg = 0;
  setjeWeg = 0;
  spelerMetBeurt = 0;
  hoevaakOpKaartGeklikt = 0;
  voorkantKaartKleur1 = #FFFFFF;
  voorkantKaartKleur2 = #FFFFFF;
  xKaartGeklikt = 0;
  yKaartGeklikt = 0;
  xKaart = 0;
  yKaart = 0;
  kolomKaart1 = 0;
  rijKaart1 = 0;
  kolomKaart2 = 0;
  rijKaart2 = 0;
  doodskaartOfNormaleKaartKleur = GROEN;
  kaart = 0;
  xCorrectie = 0;
  yCorrectie = 0;
  spelerScore = new int[] {0, 0, 0, 0};
  geklikteKaarten = new int[][] {
    {WIT, WIT, WIT, WIT, WIT, WIT, WIT, WIT}, 
    {WIT, WIT, WIT, WIT, WIT, WIT, WIT, WIT}, 
    {WIT, WIT, WIT, WIT, WIT, WIT, WIT, WIT}, 
    {WIT, WIT, WIT, WIT, WIT, WIT, WIT, WIT}, 
    {WIT, WIT, WIT, WIT, WIT, WIT, WIT, WIT}, 
  };
}


void tekenKnoppen() {
  xKnop = 0;
  for (int kolom = 0; kolom < eindschermKnopOpties.length; kolom++) {
    eindSchermKnopBreedte = width / 3;
    eindSchermKnopHoogte = height/2;
    xKnop = eindSchermKnopBreedte * kolom;
    yKnop = eindSchermKnopHoogte;
    xText = xKnop + eindSchermKnopBreedte / 4;
    yText = yKnop + eindSchermKnopHoogte / 4;
    tekenKnop(xKnop, yKnop, #0F0F0F);
    for (int rij = 0; rij < eindschermKnopOpties[kolom].length; rij++) {
      yText = yText + getTekstGroottes("normaal");
      tekenKnoppenTekst(eindschermKnopOpties[kolom][rij], xText, yText, ROOD);
    }
  }
}

void tekenKnop(int x, int y, int kleur) {
  fill(kleur);
  rect(x, y, eindSchermKnopBreedte, eindSchermKnopHoogte, 50);
}

int getTekstGroottes(String tekst) {
  switch (tekst) {
  case "klein":
    return kleineTekstGrootte;
  case "normaal":
    return normaleTekstGrootte;
  case "groot":
    return groteTekstGrootte;
  }
  return kleineTekstGrootte;
}

void tekenKnoppenTekst(String tekst, int x, int y, int kleur) {
  fill(kleur);
  text(tekst, x, y);
}
