void tekenEindScherm() {
  aantalSpelers = getSpelers();
  berekenOptiesTekst(); //WEGHALEN NA SCHRIJVEN CODE!!!!________________________________________________________
  tekenScores();
}

void eindSchermActies() {
}

void tekenScores() {
  int xScores = width/8;
  int yScores = height/4;
  int tekstGrootte = getTekstGroottes("normaal");
  textSize(tekstGrootte);
  text("Scores", xScores, yScores);
  for (int i = 0; i < getSpelers(); i++) {
    tekenSpelerMetScore(getScore(i), i, xScores, yScores, tekstGrootte, getKleur("GEEL"));
  }
}

void tekenSpelerMetScore(int spelerScore, int i, int x, int y, int rijVerschil, int kleur) {
  fill(kleur);
  text("Speler "+ (i+1) + " eindscore: " + spelerScore, x, y + rijVerschil + rijVerschil * i);
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

int getScore(int i) {
  return spelerScore[i];
}

int getSpelers() {
  return aantalSpelers;
}
