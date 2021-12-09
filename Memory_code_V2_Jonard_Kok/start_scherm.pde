/*
NODIG:
 Knop die de hoeveelheid spelers instelt.
 Doodskaarten[ja][nee]
 aantal setjes(12 16 20 24 28) 
 knop om het spel te starten
 */
int aantalSetjes = 12;
int aantalSpelers = 1;
int maximumAantalSpelers = 4;
int minimumAantalSpelers = 1;
final int TEKST_KLEUR = #FFFFFF;
String spelers = str(aantalSpelers);
String aantalSetjesTekst = str(aantalSetjes);
String jaOfNee = "nee";
String[][] optieKnoppen = {
  { "-", "+", spelers}, 
  {"Nee", "Ja", jaOfNee}, 
  { "12", "16", "20", aantalSetjesTekst}
};
String[] menuTekst = {"Aantal spelers: ", "Doodskaarten?", "Aantal setjes:"};
String[] startEnStopKnop = {"Start spel", "Stop spel"};
int knop;
int kleineTekstGrootte;
int normaleTekstGrootte;
int groteTekstGrootte;
int xTekstPlek;
int yTekstPlek;
int knopTussenRuimte;
int menuTextBreedte;
int knopTextBreedte;
int knopBreedte;
int knopHoogte;
int geklikteKnopKolom;
int geklikteKnopRij;
int knopKleuren[][]= {
  {getKleuren("ROOD"), getKleuren("GROEN"), getKleuren("GRIJS"), }, 
  {getKleuren("ROOD"), getKleuren("GROEN"), getKleuren("GRIJS") }, 
  {getKleuren("GROEN"), getKleuren("GROEN"), getKleuren("GROEN"), getKleuren("GRIJS") }, 
};
int actieKnopKleuren[] = {getKleuren("GROEN"), getKleuren("ROOD")};
boolean doodsKaarten;  
boolean groottesBerekend;
boolean opMinGedrukt;
boolean opPlusGedrukt;
boolean opJaGedrukt;
boolean opNeeGedrukt;
boolean op12Gedrukt;
boolean op16Gedrukt;
boolean op20Gedrukt;
boolean opStartGedrukt;
boolean opStopGedrukt;
boolean[][] knopKlik = {
  {opMinGedrukt, opPlusGedrukt}, 
  {opJaGedrukt, opNeeGedrukt}, 
  {op12Gedrukt, op16Gedrukt, op20Gedrukt}, 
  {opStartGedrukt, opStopGedrukt}
};


void tekenStartScherm() {
  if (!groottesBerekend) {
    berekenOpties();
  }
  tekenOpties(width/100, height/100);
}

void veranderStartScherm() {
  berekenKlikPlek();
  knopKlik[geklikteKnopKolom][geklikteKnopRij] = true;
  neemActie();
}

void neemActie() {
  println(geklikteKnopKolom, geklikteKnopRij);
  for (int i = 0; i < knopKlik.length; i++) {
    for (int j = 0; j < knopKlik[i].length; j++) {
      println(knopKlik[i][j]);
    }
  }
  if (opPlusGedrukt) {
    println("plus");
    if (kanSpelerPlus()) {//wilde hier een switch statement van maken maar dat werkt niet met arrays blijkbaar.
      aantalSpelers++;
      spelers = str(aantalSpelers);
    }
  } else if (opMinGedrukt) {
    println("min");
    if (kanSpelerMin()) {
      aantalSpelers--;
      spelers = str(aantalSpelers);
    }
  } else if (opJaGedrukt) {
    println("ja");
    jaOfNee = "ja";
    doodsKaarten = true;
  } else if (opNeeGedrukt) {
    println("nee");
    jaOfNee = "nee";
    doodsKaarten = false;
  } else if (op12Gedrukt) {
    println("12");
    aantalSetjes = 12;
    aantalSetjesTekst = str(aantalSetjes);
  } else if (op16Gedrukt) {
    println("16");
    aantalSetjes = 16;
    aantalSetjesTekst = str(aantalSetjes);
  } else if (op20Gedrukt) {
    println("20");
    aantalSetjes = 20;
    aantalSetjesTekst = str(aantalSetjes);
  } else if (opStartGedrukt) {
    scherm = SPEL_SCHERM;
  } else if (opStopGedrukt) {
    exit();
  }
  knopKlik[geklikteKnopKolom][geklikteKnopRij] = false;
  updateOptieKnoppen();
}

void updateOptieKnoppen() {
  optieKnoppen = new String[][] {
    { "-", "+", spelers}, 
    {"Nee", "Ja", jaOfNee}, 
    { "12", "16", "20", aantalSetjesTekst}
  };
}

void berekenKlikPlek() {
  opInstellingenGeklikt();
  opStartOfStopGeklikt();
}
int knopgeklikt = 0;

void opInstellingenGeklikt() {
  int yPlek;
  for (int i = 0; i < optieKnoppen.length; i++) {
    for (int j = 0; j < optieKnoppen[i].length; j++) {
      yPlek = normaleTekstGrootte + normaleTekstGrootte * i;
      if (opStartschermKnopGeklikt(berekenXplek(j), berekenYPlek(yPlek), knopBreedte, knopHoogte, knopKleuren[i][j])) {
        geklikteKnopKolom = i;
        geklikteKnopRij = j;
        knopgeklikt++;
        println("op een knop geklikt", knopgeklikt, geklikteKnopKolom, geklikteKnopRij);
      }
    }
  }
}

void opStartOfStopGeklikt() {
  for (int i = 0; i < startEnStopKnop.length; i++) {
    if (opStartschermKnopGeklikt((width/2)*i, height/2, width/2, height/2, actieKnopKleuren[i])) {
      geklikteKnopKolom = 3;
      geklikteKnopRij = i;
    }
  }
}

void berekenOpties() {
  berekenTekstGroottes();
  berekenKnopBreedte();
  groottesBerekend = true;
}

void berekenKnopBreedte() {
  knopBreedte = width / 13;
  knopHoogte = height / 13;
  knopTussenRuimte = width/100;
}

void berekenTekstGroottes() {
  kleineTekstGrootte = ((width+height) / 2) / 50;
  normaleTekstGrootte = ((width+height) / 2) / 15;
  groteTekstGrootte = ((width+height) / 2) / 10;
}

void tekenOpties(int xPlek, int yPlek) {
  for (int i = 0; i < menuTekst.length; i++) {//tekent 
    yPlek = normaleTekstGrootte + normaleTekstGrootte * i;
    tekenTekst(menuTekst[i], xPlek, yPlek, normaleTekstGrootte);
    for (int j = 0; j < optieKnoppen[i].length; j++) {
      tekenKnopMetTekst(berekenXplek(j), berekenYPlek(yPlek), knopBreedte, knopHoogte, 10, knopKleuren[i][j], kleineTekstGrootte, optieKnoppen[i][j]);
    }
    tekenActieKnoppen(0, height / 2, startEnStopKnop[knop], i);
  }
}

void tekenActieKnoppen(int x, int y, String tekst, int arrayPlek) {
  if (arrayPlek > 1) {
    arrayPlek = arrayPlek-2;
  }
  tekenKnopMetTekst(x + (width/2)*arrayPlek, y, width/2, height/2, 10, actieKnopKleuren[arrayPlek], groteTekstGrootte, tekst);
}

void tekenTekst(String tekst, int x, int y, int tekstGrootte) {
  textSize(tekstGrootte);
  fill(TEKST_KLEUR);
  text(tekst, x, y);
}

int getKleuren(String kleur) {
  switch(kleur) {
  case "ROOD":
    return ROOD;
  case  "GRIJS":
    return GRIJS;
  case "GROEN":
    return GROEN;
  }
  return 0;
}

void tekenKnop(int x, int y, int breedte, int hoogte, int radius, int kleur) {//komt uit bug squash
  fill(kleur);
  rect(x, y, breedte, hoogte, radius);
}

void berekenKnop(int x, int y, int tekstGrootte) {
  x = x + knopBreedte / 4;
  y = y - tekstGrootte / 10;
  xTekstPlek = x;
  yTekstPlek = y + tekstGrootte + tekstGrootte / 3;
}

void tekenKnopMetTekst(int x, int y, int breedte, int hoogte, int radius, int kleur, int tekstGrootte, String tekst) {
  berekenKnop(x, y, tekstGrootte);
  tekenKnop(x, y, breedte, hoogte, radius, kleur);
  fill(TEKST_KLEUR);
  textSize(tekstGrootte);
  if (tekst == "Nee" || tekst == "nee") {
    text(tekst, xTekstPlek - breedte / 10, yTekstPlek);
  } else if (tekst != "Nee") {
    text(tekst, xTekstPlek, yTekstPlek);
  }
}

boolean kanSpelerPlus() {
  return aantalSpelers < maximumAantalSpelers;
}

boolean kanSpelerMin() {
  return aantalSpelers > minimumAantalSpelers;
}

boolean startscherm() {//komt uit bug squash
  return scherm == START_SCHERM;
}

boolean opStartschermKnopGeklikt (int x, int y, int breedte, int hoogte, int kleur) {
  return mouseX > x && mouseX < x + breedte && mouseY > y && mouseY < y + hoogte && startscherm() && kleur != getKleuren("GRIJS");
}

int berekenXplek(int factor) {
  return width/2 + knopBreedte * factor + knopTussenRuimte * factor;
}

int berekenYPlek(int yPlek) {
  return yPlek-normaleTekstGrootte/2-width/200;
}
