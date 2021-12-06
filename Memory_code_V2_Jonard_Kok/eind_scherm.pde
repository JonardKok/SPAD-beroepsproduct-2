void tekenEindScherm() {
  tekenScores();
  text("Eind-scherm", width / 2, height / 2);
}

void eindSchermActies() {
}

void tekenScores() {
  int xScores = width/4;
  int yScores = height/4;
  text("scores", xScores, yScores);
  for (int i = 0; i < getSpelers(); i++) {
    tekenSpelerMetScore(getScore(i), i, xScores, getTekstGroottes("klein"), getKleur("GEEL"));
  }
}

void tekenSpelerMetScore(int spelerScore, int i, int x, int y, int kleur) {
  fill(kleur);
  text("Speler"+ (i+1) + "Score: " + spelerScore, x, y*2 + y * i);
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
