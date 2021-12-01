int[][] kleurKaart;
int[][] kaarten = new int [4][5];
int aantalKaarten=20;
void setup() {
  berekenKaartKleur();
  exit();
}

void berekenKaartKleur() {
  kleurKaart = kaarten;
  println("boe" + kleurKaart.length);
  for (int i = 0; i < kleurKaart.length; i++) {
    for (int j = 0; j < kleurKaart[i].length; j++) {
      kleurKaart[i][j] = int(random(1, (aantalKaarten) + 1));
      int kleurFrequentie = 0;
      for (int k = 0; k < kleurKaart.length; k++) {
        for (int l = 0; l < kleurKaart[k].length; l++) {//gaat de hele rij af om te kijken of de kleur al 2x bestaat.
          if (kleurKaart[i][j] != 0 && kleurKaart[i][j] == kleurKaart[k][l]) {
            kleurFrequentie++;
          }
          if (kleurFrequentie >= 2 && j > 0) {
            j--;
            kleurFrequentie = 0;
          }
        }
      }
    }  
    for (int j = 0; j < kleurKaart[i].length; j++) {
      println(i+1,j+1, "kleurkaart "+kleurKaart[i][j] );//kaartkleur is berekend
    }
  }
}
//kaartPlekkenZijnBerekend = true;


/*boolean komtCijferVakerVoor(int cijferFrequentie, int j) {
  return cijferFrequentie > 2 && j > 0;
}*/
