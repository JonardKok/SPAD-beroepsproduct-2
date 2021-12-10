final int MAXIMUMAANTALSPELERS = 4;
final int MINIMUMAANTALSPELERS = 1;
int aantalSetjes = 12;
int aantalSpelers = 1;
String spelers = "1";
String aantalSetjesTekst = "12";
String jaOfNee = "nee";
String[][] optieKnoppen = {
  { "-", "+", spelers}, 
  {"Nee", "Ja", jaOfNee}, 
  { "12", "16", "20", aantalSetjesTekst}
};
String[] menuTekst = {"Aantal spelers: ", "Doodskaarten?", "Aantal setjes:"};
String[] startEnStopKnop = {"Start spel", "Stop spel"};
int kleineTekstGrootte;
int normaleTekstGrootte;
int groteTekstGrootte;
int xTekstPlek;
int yTekstPlek;
int knopTussenRuimte;
int knopBreedte;
int knopHoogte;
int geklikteKnopKolom;
int geklikteKnopRij;
boolean doodsKaarten;
boolean groottesBerekend;
String geklikteKnop;
int knopKleuren[][]= {
  {getKleuren("ROOD"), getKleuren("GROEN"), getKleuren("GRIJS"), }, 
  {getKleuren("ROOD"), getKleuren("GROEN"), getKleuren("GRIJS") }, 
  {getKleuren("GROEN"), getKleuren("GROEN"), getKleuren("GROEN"), getKleuren("GRIJS") }, 
};
int actieKnopKleuren[] = {getKleuren("GROEN"), getKleuren("ROOD")};
String[][] knopKlik = {
  {"min", "plus"}, 
  {"nee", "ja"}, 
  {"12", "16", "20"}, 
  {"start", "stop"}
};

void tekenStartScherm() { //tekent het hele startscherm.
  if (!groottesBerekend) {
    berekenOpties();
  }
  tekenOpties(width/100, height/100);
}

void berekenOpties() { //Bereknt de plekken van de opties.
  berekenKnopGroottes();
  berekenTekstGroottes();
  groottesBerekend = true;
}

void berekenKnopGroottes() { //Berekent de groottes van de knop.
  knopBreedte = width / 13;
  knopHoogte = height / 13;
  knopTussenRuimte = width/100;
}

void berekenTekstGroottes() {//Berekent de groottes van de tekst zodat het er altijd goed uit ziet.
  kleineTekstGrootte = ((width+height) / 2) / 50;
  normaleTekstGrootte = ((width+height) / 2) / 15;
  groteTekstGrootte = ((width+height) / 2) / 10;
}

void tekenOpties(int xPlek, int yPlek) {//tekent de tekst en de knoppen in het menu.
  for (int i = 0; i < menuTekst.length; i++) {
    yPlek = normaleTekstGrootte + normaleTekstGrootte * i;
    tekenTekst(menuTekst[i], xPlek, yPlek, normaleTekstGrootte);
    for (int j = 0; j < optieKnoppen[i].length; j++) {
      tekenKnopMetTekst(berekenXPlek(j), berekenYPlek(yPlek), knopBreedte, knopHoogte, 10, knopKleuren[i][j], kleineTekstGrootte, optieKnoppen[i][j]);
    }
    if (i < 2) {
      tekenActieKnoppen(0, height / 2, startEnStopKnop[i], i);
    }
  }
}

void tekenTekst(String tekst, int x, int y, int tekstGrootte) {//tekent de tekst.
  textSize(tekstGrootte);
  fill(getKleuren("WIT"));
  text(tekst, x, y);
}

//Tekent de menuknoppen met tekst.
void tekenKnopMetTekst(int x, int y, int breedte, int hoogte, int radius, int kleur, int tekstGrootte, String tekst) {
  berekenKnop(x, y, tekstGrootte);
  tekenKnop(x, y, breedte, hoogte, radius, kleur);
  fill(getKleuren("WIT"));
  textSize(tekstGrootte);
  if (tekst == "Nee" || tekst == "nee") {
    text(tekst, xTekstPlek - breedte / 10, yTekstPlek);
  } else if (tekst != "Nee") {
    text(tekst, xTekstPlek, yTekstPlek);
  }
}

void berekenKnop(int x, int y, int tekstGrootte) {//berekent de knopplekken.
  y = y - tekstGrootte / 10;
  xTekstPlek = x + knopBreedte / 3;
  yTekstPlek = y + tekstGrootte + tekstGrootte / 3;
}

void tekenKnop(int x, int y, int breedte, int hoogte, int radius, int kleur) {//komt uit bug squash
  fill(kleur);
  rect(x, y, breedte, hoogte, radius);
}

void tekenActieKnoppen(int x, int y, String tekst, int arrayPlek) {
  tekenKnopMetTekst(x + (width/2)*arrayPlek, y, width/2, height/2, 10, actieKnopKleuren[arrayPlek], groteTekstGrootte, tekst);
}

void veranderSpelInstellingen() {
  berekenKlikPlek();
  geklikteKnop = knopKlik[geklikteKnopKolom][geklikteKnopRij];
  neemActie();
}

void berekenKlikPlek() {
  opInstellingenGeklikt();
  opStartOfStopGeklikt();
}

void opInstellingenGeklikt() {
  int yPlek;
  for (int i = 0; i < optieKnoppen.length; i++) {
    for (int j = 0; j < optieKnoppen[i].length; j++) {
      yPlek = normaleTekstGrootte + normaleTekstGrootte * i;
      if (opStartschermKnopGeklikt(berekenXPlek(j), berekenYPlek(yPlek), knopBreedte, knopHoogte, knopKleuren[i][j])) {
        geklikteKnopKolom = i;
        geklikteKnopRij = j;
      }
    }
  }
}

int berekenXPlek(int factor) { //berekent de x-coordinaat van de optieknoppen.
  return width/2 + knopBreedte * factor + knopTussenRuimte * factor;
}

int berekenYPlek(int yPlek) {
  return yPlek-normaleTekstGrootte/2-width/200;
}

void opStartOfStopGeklikt() {
  for (int i = 0; i < startEnStopKnop.length; i++) {
    if (opStartschermKnopGeklikt((width/2)*i, height/2, width/2, height/2, actieKnopKleuren[i])) {
      geklikteKnopKolom = 3;
      geklikteKnopRij = i;
    }
  }
}

boolean opStartschermKnopGeklikt (int x, int y, int breedte, int hoogte, int kleur) {
  return mouseX > x && mouseX < x + breedte && mouseY > y && mouseY < y + hoogte && startscherm() && kleur != getKleuren("GRIJS");
}

boolean startscherm() {//komt uit bug squash
  return scherm == START_SCHERM;
}

void neemActie() {
  switch (geklikteKnop) {
  case "min":
    if (aantalSpelers > MINIMUMAANTALSPELERS) {
      aantalSpelers--;
      spelers = str(aantalSpelers);
    }
    break;
  case "plus":
    if (aantalSpelers < MAXIMUMAANTALSPELERS) {
      aantalSpelers++;
      spelers = str(aantalSpelers);
    }
    break;
  case "ja":
    jaOfNee = geklikteKnop;
    doodsKaarten = true;
    break;
  case "nee":
    jaOfNee = geklikteKnop;
    doodsKaarten = false;
    break;
  case "12":
  case "16":
  case "20":
    aantalSetjes = int(geklikteKnop);
    aantalSetjesTekst = str(aantalSetjes);
    break;
  case "start":
    scherm = SPEL_SCHERM;
    break;
  case "stop":
    exit();
    break;
  }
  geklikteKnop = "leeg";
  updateOptieKnoppen();
}

void updateOptieKnoppen() {
  optieKnoppen = new String[][] {
    { "-", "+", spelers}, 
    {"Nee", "Ja", jaOfNee}, 
    { "12", "16", "20", aantalSetjesTekst}
  };
}

int getKleuren(String kleur) {
  switch(kleur) {
  case "ROOD":
    return ROOD;
  case  "GRIJS":
    return GRIJS;
  case "GROEN":
    return GROEN;
  case "WIT":
    return WIT;
  }
  return 0;
}  
