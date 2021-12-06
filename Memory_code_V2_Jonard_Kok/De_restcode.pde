
//void berekenKaartKleuren() {
//  kaartKleur = new int[plekkenMetKaart.length][plekkenMetKaart[0].length];
//  for (int i = 0; i < kaartKleur.length; i++) {
//    for (int j = 0; j < kaartKleur[i].length; j++) {
//      kaartKleur[i][j] = int(random(1, (aantalSetjes) + 1));
//      kaartKleur[i][j] = kaartKleur[i][j] - 1;
//      int kleurFrequentie = 0;
//      for (int k = 0; k < kaartKleur.length; k++) {
//        for (int l = 0; l < kaartKleur[k].length; l++) {//gaat de hele rij af om te kijken of de kleur al 2x bestaat.
//          if (kaartKleur[k][l] == kaartKleur[i][j]) {
//            kleurFrequentie++;
//            if (kleurFrequentie >= 3 && j > 0) {
//              kleurFrequentie = 0;
//              j -=1;
//            }
//          }
//        }
//      }
//    }
//    kaartPlekkenZijnBerekend = true;
//  }
//}
