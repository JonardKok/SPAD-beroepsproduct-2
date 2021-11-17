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

//tekst en tekstgroottes
String spelers = str(aantalSpelers);
String aantalSetjesTekst = str(aantalSetjes);
String jaOfNee = ("nee");
String[][][] menuTekst;
int xTekstPlek;
int yTekstPlek;
int kleineTekstGrootte;
int normaleTekstGrootte;
int groteTekstGrootte;
int menuTextBreedte;
int knopTextBreedte;
int knopBreedte;
int knopHoogte;


//knoppengroottes
int kleineTekstKnopBreedte;
int kleineTekstKnopHoogte;

//Op bepaalde knop gedrukt
boolean opMinGedrukt;
boolean opPlusGedrukt;
boolean opJaGedrukt;
boolean opNeeGedrukt;
boolean op12Gedrukt;
boolean op16Gedrukt;
boolean op20Gedrukt;
boolean opStartGedrukt;
boolean opStopGedrukt;
boolean[] knop = {opMinGedrukt, opPlusGedrukt, opJaGedrukt, opNeeGedrukt, op12Gedrukt, op16Gedrukt, op20Gedrukt, opStartGedrukt, opStopGedrukt};


void tekenStartScherm() {
  opties();
}

void veranderStartScherm() {
  instellingVeranderd();
}

void instellingVeranderd() {
  if (opPlusGedrukt) {
    if (kanSpelerPlus()) {
      aantalSpelers++;
      spelers = str(aantalSpelers);
    }
  } else if (opMinGedrukt) {
    if (kanSpelerMin()) {
      aantalSpelers--;
      spelers = str(aantalSpelers);
    }
  } else if (opJaGedrukt) {
    jaOfNee = "ja";
    doodsKaarten = true;
  } else if (opNeeGedrukt) {
    jaOfNee = "nee";
    doodsKaarten = false;
  } else if (op12Gedrukt) {
    aantalSetjes = 12;
    aantalSetjesTekst = str(aantalSetjes);
  } else if (op16Gedrukt) {
    aantalSetjes = 16;
    aantalSetjesTekst = str(aantalSetjes);
  } else if (op20Gedrukt) {
    aantalSetjes = 20;
    aantalSetjesTekst = str(aantalSetjes);
  } else if (opStartGedrukt) {
    scherm = SPEL_SCHERM;
  } else if (opStopGedrukt) {
    exit();
  }
}

void opties() {
  berekenOpties();
  tekenOpties(100, 250);
}

void berekenOpties() {
  berekenOptiesTekst();
}

void menuOpties() {
}

void berekenOptiesTekst() {
  kleineTekstGrootte = ((width+height) / 2) / 50;
  normaleTekstGrootte = ((width+height) / 2) / 15;
  groteTekstGrootte = ((width+height) / 2) / 10;
  kleineTekstKnopBreedte = kleineTekstGrootte;
  kleineTekstKnopHoogte = kleineTekstGrootte + kleineTekstGrootte/2;
}

void tekenOpties(int x, int y) {
  menuTekst = new String[][][] {
    { {"Opties"} }, //titel
    { {"Aantal spelers: "}, {"Doodskaarten?"}, {"Aantal setjes:"}}, //tekst van opties
    { {"-", spelers, "+"}, {"Nee", "Ja", jaOfNee}, {"12", "16", "20", aantalSetjesTekst}, {"Start spel", "Stop spel"} }//knoppenopties
  };
  for (int i = 0; i < menuTekst.length; i++) {
    if (i == 0) {//titel
      for (int j = 0; j < menuTekst[i].length; j++) {
        for (int k = 0; k < menuTekst[i][j].length; k++) {
          tekst(menuTekst[i][j][k], x, y - (groteTekstGrootte / 2), groteTekstGrootte);
        }
      }
    } else if (i == 1) {//opties
      y = y + groteTekstGrootte / 4;
      for (int j = 0; j < menuTekst[i].length; j++) {
        for (int k = 0; k < menuTekst[i][j].length; k++) {
          tekst(menuTekst[i][j][k], x, y + ((normaleTekstGrootte + normaleTekstGrootte / 10)*j) + (normaleTekstGrootte*k), normaleTekstGrootte);
        }
      }
    } else if (i > 1) {//knoppen
      for (int j = 0; j < menuTekst[i].length; j++) { //HIER KAN EEN METHODE VOOR GEMAAKT WORDEN!
        for (int k = 0; k < menuTekst[i][j].length; k++) {//moet zo omdat je geen String array in een switch statement kan zetten, helemaal kut.
          //tekenKnoppen(x, y, i, j, k);
          if (menuTekst[i][j][k] == menuTekst[2][0][0]) {//tekent -
            menuTextBreedte = int(textWidth(menuTekst[1][0][0]));
            textSize(kleineTekstGrootte);
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = x + menuTextBreedte;
            y = y - groteTekstGrootte / 3;
            knopBreedte = kleineTekstKnopBreedte + knopTextBreedte;
            tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, ROOD, kleineTekstGrootte, menuTekst[i][j][k]);
            opMinGedrukt = opStartschermKnopGeklikt(x, y, knopBreedte, kleineTekstKnopHoogte);
          } else if (menuTekst[i][j][k] == menuTekst[2][0][1]) { //tekent hoeveelheid spelers
            menuTextBreedte = int(textWidth(menuTekst[1][0][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = x + menuTextBreedte / 3;
            knopBreedte = kleineTekstKnopBreedte + knopTextBreedte;
            tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, GRIJS, kleineTekstGrootte, menuTekst[i][j][k]);
          } else if (menuTekst[i][j][k] == menuTekst[2][0][2]) { //tekent +
            menuTextBreedte = int(textWidth(menuTekst[1][0][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = x + menuTextBreedte / 3;
            knopBreedte = kleineTekstKnopBreedte + knopTextBreedte;
            tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, GROEN, kleineTekstGrootte, menuTekst[i][j][k]);
            opPlusGedrukt = opStartschermKnopGeklikt(x, y, knopBreedte, kleineTekstKnopHoogte);
          } else if (menuTekst[i][j][k] == menuTekst[2][1][0]) {//tekent nee
            menuTextBreedte = int(textWidth(menuTekst[1][1][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = x - menuTextBreedte / 2 - (menuTextBreedte / 8);
            y = y + groteTekstGrootte - groteTekstGrootte / 4;
            knopBreedte = kleineTekstKnopBreedte + knopTextBreedte;
            tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, ROOD, kleineTekstGrootte, menuTekst[i][j][k]);
            opNeeGedrukt = opStartschermKnopGeklikt(x, y, knopBreedte, kleineTekstKnopHoogte);
          } else if (menuTekst[i][j][k] == menuTekst[2][1][1]) {//tekent ja
            menuTextBreedte = int(textWidth(menuTekst[1][1][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = x + menuTextBreedte / 2;
            knopBreedte = knopTextBreedte + kleineTekstKnopBreedte;
            tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, GROEN, kleineTekstGrootte, menuTekst[i][j][k]);
            opJaGedrukt = opStartschermKnopGeklikt(x, y, knopBreedte, kleineTekstKnopHoogte);
          } else if (menuTekst[i][j][k] == menuTekst[2][1][2]) {//tekent optie
            menuTextBreedte = int(textWidth(menuTekst[1][1][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = x + menuTextBreedte / 3;
            knopBreedte = knopTextBreedte + kleineTekstKnopBreedte;
            tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, GRIJS, kleineTekstGrootte, menuTekst[i][j][k]);
          } else if (menuTekst[i][j][k] == menuTekst[2][2][0]) { //tekent 12
            menuTextBreedte = int(textWidth(menuTekst[1][2][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = x - menuTextBreedte - menuTextBreedte / 3;
            y = y + groteTekstGrootte - groteTekstGrootte / 4;
            knopBreedte = kleineTekstKnopBreedte + knopTextBreedte;
            tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, GROEN, kleineTekstGrootte, menuTekst[i][j][k]);
            op12Gedrukt = opStartschermKnopGeklikt(x, y, knopBreedte, kleineTekstKnopHoogte);
          } else if (menuTekst[i][j][k] == menuTekst[2][2][1]) {//tekent 16
            menuTextBreedte = int(textWidth(menuTekst[1][2][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = x + knopTextBreedte * 2;
            tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, GROEN, kleineTekstGrootte, menuTekst[i][j][k]);
            op16Gedrukt = opStartschermKnopGeklikt(x, y, knopBreedte, kleineTekstKnopHoogte);
          } else if (menuTekst[i][j][k] == menuTekst[2][2][2]) {//tekent 20
            menuTextBreedte = int(textWidth(menuTekst[1][1][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = x + knopTextBreedte * 2;
            tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, GROEN, kleineTekstGrootte, menuTekst[i][j][k]);
            op20Gedrukt = opStartschermKnopGeklikt(x, y, knopBreedte, kleineTekstKnopHoogte);
          } else if (menuTekst[i][j][k] == menuTekst[2][2][3]) {//tekent aantal setjes
            menuTextBreedte = int(textWidth(menuTekst[1][1][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = x + knopTextBreedte * 2;
            tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, GRIJS, kleineTekstGrootte, menuTekst[i][j][k]);
          } else if (menuTekst[i][j][k] == menuTekst[2][3][0]) {//tekent startknop
            menuTextBreedte = int(textWidth(menuTekst[1][1][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = 0;
            y = y + groteTekstGrootte - groteTekstGrootte / 4;
            knopBreedte = width / 2;
            knopHoogte = height - y;
            tekenKnopMetTekst(x, y, knopBreedte, knopHoogte, 10, 10, 10, 10, GROEN, groteTekstGrootte, menuTekst[i][j][k]);
            opStartGedrukt = opStartschermKnopGeklikt(x, y, knopBreedte, knopHoogte);
          } else if (menuTekst[i][j][k] == menuTekst[2][3][1]) {//tekent stopknop
            menuTextBreedte = int(textWidth(menuTekst[1][1][0]));
            knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
            x = width / 2;
            knopBreedte = width / 2;
            knopHoogte = height - y;
            tekenKnopMetTekst(x, y, knopBreedte, knopHoogte, 10, 10, 10, 10, ROOD, groteTekstGrootte, menuTekst[i][j][k]);
            opStopGedrukt = opStartschermKnopGeklikt(x, y, knopBreedte, knopHoogte);
          }
        }
      }
    }
  }
}

//void tekenKnoppen(int x, int y, int i, int j, int k) {
//  textSize(kleineTekstGrootte);
//  menuTextBreedte = int(textWidth(menuTekst[1][0][0]));
//  knopTextBreedte = int(textWidth(menuTekst[i][j][k]));
//  x = x + menuTextBreedte;
//  y = y - groteTekstGrootte / 3;
//  knopBreedte = kleineTekstKnopBreedte + knopTextBreedte;
//  tekenKnopMetTekst(x, y, knopBreedte, kleineTekstKnopHoogte, 10, 10, 10, 10, ROOD, kleineTekstGrootte, menuTekst[i][j][k]);
//}


void tekst(String tekst, int x, int y, int tekstGrootte) {
  textSize(tekstGrootte);
  fill(TEKST_KLEUR);
  text(tekst, x, y);
}

void tekenKnop(int x, int y, int breedte, int hoogte, int radiusTL, int radiusTR, int radiusBR, int radiusBL, int kleur) {//komt uit bug squash
  fill(kleur);
  rect(x, y, breedte, hoogte, radiusTL, radiusTR, radiusBR, radiusBL);
}

void berekenKnop(int x, int y, int tekstGrootte) {
  x = x + knopBreedte / 4;
  y = y - tekstGrootte / 10;
  xTekstPlek = x;
  yTekstPlek = y + tekstGrootte + tekstGrootte / 3;
}

void tekenKnopMetTekst(int x, int y, int breedte, int hoogte, int radiusTL, int radiusTR, int radiusBR, int radiusBL, int kleur, int tekstGrootte, String tekst) {
  berekenKnop(x, y, tekstGrootte);
  tekenKnop(x, y, breedte, hoogte, radiusTL, radiusTR, radiusBR, radiusBL, kleur);
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

boolean opStartschermKnopGeklikt (int x, int y, int breedte, int hoogte) {
  return mouseX > x && mouseX < x + breedte && mouseY > y && mouseY < y + hoogte && startscherm();
}
