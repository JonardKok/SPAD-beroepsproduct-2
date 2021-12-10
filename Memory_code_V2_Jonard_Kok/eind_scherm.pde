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

void tekenEindScherm() {// tekent het eindscherm
  tekenScores();
  tekenKnoppen();
}

int getSpelers() {//haalt het aantal spelers op uit het startscherm.
  return aantalSpelers;
}

void tekenScores() {//tekent de scores van de spelers.
  berekenPlekken();
  textSize(eindSchermTekstGrootte);
  fill(getKleur("GEEL"));
  text("Scores", xScores, yScores);
  for (int i = 0; i < getSpelers(); i++) {
    tekenSpelerMetScore(getScore(i), i, xScores, yScores, eindSchermTekstGrootte);
  }
}

void berekenPlekken() {//berekend de plekken van de sscores.
  eindSchermTekstGrootte = getTekstGroottes("normaal");
  xScores = width/100;
  yScores = eindSchermTekstGrootte;
}

int getKleur(String kleurNaam) {// haalt de kleur op van het spelscherm
  if (kleurNaam == "GEEL") {
    return GEEL;
  }
  return 255;
}

int getScore(int spelerNummer) {//haalt de spelerscore op
  return spelerScore[spelerNummer];
}

void tekenSpelerMetScore(int spelerScore, int i, int x, int y, int rijVerschil) {//tekent de speler met de score naast de naam van de speler.
  text("Speler "+ (i+1) + " eindscore: " + spelerScore, x, y + rijVerschil + rijVerschil * i);
}

void tekenKnoppen() {//tekent de knoppen waarop geklikt kan worden.
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

void tekenKnop(int x, int y, int kleur) {//tekent 1 knop.
  fill(kleur);
  rect(x, y, eindSchermKnopBreedte, eindSchermKnopHoogte, 50);
}

int getTekstGroottes(String tekst) {//methode die de tekstgroottes ophaalt vanuit het startscherm.
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

void tekenKnoppenTekst(String tekst, int x, int y, int kleur) {//methode die de tekst van de knoppen tekent.
  fill(kleur);
  text(tekst, x, y);
}

void eindSchermActies() {//veranderd het scherm als er op het spelscherm is geklikt.
  knopActie(zoekKnop());
}

String zoekKnop() {//methode die zoekt naar de geklikte knop.
  for (int knopNummer = 0; knopNummer < knopNaam.length; knopNummer++) {
    xKnop = eindSchermKnopBreedte * knopNummer;
    yKnop = height / 2;
    if (opEindschermKnopGedrukt (xKnop, yKnop, eindSchermKnopBreedte, eindSchermKnopHoogte)) {
      return knopNaam[knopNummer];
    }
  }
  return "geen_knop";
}

boolean opEindschermKnopGedrukt (int x, int y, int breedte, int hoogte) {//bepaald of er op een knop is gedrukt.
  return mouseX > x && mouseX < x + breedte && mouseY > y && mouseY < y + hoogte && isSchermEindscherm();
}

boolean isSchermEindscherm() {//bepaald of het scherm het eindscherm is.
  return scherm == EIND_SCHERM;
}

void knopActie(String knop) {//voert de functie van de knop uit waarop gedrukt is.
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

void setMenuResetVariabelen() {//reset alle variabelen die tijdens het draaien van het programma aangepast zijn.
  setSpelResetVariabelen();
  aantalSetjes = 12;
  aantalSpelers = 1;
  jaOfNee = "nee";
}

void setSpelResetVariabelen() {//reset alle variabelen die tijdens het spelen van het spel aangepast zijn.
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
