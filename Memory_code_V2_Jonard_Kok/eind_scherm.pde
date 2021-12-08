int eindSchermTekstGrootte;
int xScores;
int yScores;
int xKnop;
int yKnop;
int xText;
int yText;
int breedte;
int hoogte;
String[][] eindschermKnopOpties = {
  {"Ga naar", "het menu"}, 
  {"Speel het", "spel", "opnieuw"}, 
  {"Stop met", "spelen"}
};
void tekenEindScherm() {
  aantalSpelers = getSpelers();
  berekenOptiesTekst(); //WEGHALEN NA SCHRIJVEN CODE, DEZE STAAT IN HET START SCHERM!!!!________________________________________________________
  tekenScores();
  tekenKnoppen();
}

void eindSchermActies() {
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

void tekenSpelerMetScore(int spelerScore, int i, int x, int y, int rijVerschil) {
  text("Speler "+ (i+1) + " eindscore: " + spelerScore, x, y + rijVerschil + rijVerschil * i);
}

void tekenKnoppen() {
  xKnop = 0;
  for (int kolom = 0; kolom < eindschermKnopOpties.length; kolom++) {
    breedte = width / 3;
    hoogte = height/2;
    xKnop = breedte * kolom;
    yKnop = hoogte;
    xText = xKnop + breedte / 4;
    yText = yKnop + hoogte / 4;
    tekenKnop(xKnop, yKnop, #0F0F0F);
    for (int rij = 0; rij < eindschermKnopOpties[kolom].length; rij++) {
      yText = yText + getTekstGroottes("normaal");
      println(xText, yText);
      tekenKnoppenTekst(eindschermKnopOpties[kolom][rij], xText, yText);
    }
  }
}

void tekenKnop(int x, int y, int kleur) {
  fill(kleur);
  rect(x, y, breedte, hoogte, 50);
}

void tekenKnoppenTekst(String tekst, int x, int y) {
  fill(#FFFFFF);
  text(tekst, x, y);
}

int getKleur(String kleurNaam) {
  if (kleurNaam == "GEEL") {
    return GEEL;
  }
  return 255;
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
  println("Tekstgrootte is verkeerd getypt, normaal wordt gebruikt");
  return kleineTekstGrootte;
}

void setResetVariabelen(String soortKnop) {
  switch (soortKnop) {
  case "menu":
    break;
  case "opnieuw":
    break;
  }
}

int getScore(int i) {
  return spelerScore[i];
}

int getSpelers() {
  return aantalSpelers;
}

boolean eindscherm() {//komt uit bug squash
  return scherm == EIND_SCHERM;
}

boolean opEindschermKnopGedrukt (int x, int y, int breedte, int hoogte) {
  return mouseX > x && mouseX < x + breedte && mouseY > y && mouseY < y + hoogte && eindscherm();
}
