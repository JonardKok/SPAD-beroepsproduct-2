////https://forum.processing.org/two/discussion/24958/inherit-frame-rate-from-display
//import java.awt.DisplayMode; // pakt nieuwe commands.
//import java.awt.GraphicsDevice;
//import java.awt.GraphicsEnvironment;
//int hoogsteFrequentie;
//int spelFrequentie;
//void pakVernieuwingsFrequentie() {
//  GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment(); //
//  GraphicsDevice[] gs = ge.getScreenDevices(); // Maakt een array van de monitoren
//  for (int i = 0; i < gs.length; i++) { //for lus voor hoeveelheid monitoren
//    DisplayMode dm = gs[i].getDisplayMode(); //pakt de refresh rate van de monitor
//    int refreshRate = dm.getRefreshRate(); //maakt van de refresh rate een variabele
//    if (refreshRate == DisplayMode.REFRESH_RATE_UNKNOWN) { //als die niet kan zien wat de refresh rate is, is de refresh rate standaard 60.
//      refreshRate = 60;
//    }
//    vernieuwingsFrequentie(refreshRate);
//  }
//}

//void vernieuwingsFrequentie(int frequentie) { //methode die ervoor zorgt dat die de hoogste refresh rate pakt en opslaat.
//  if (frequentie > hoogsteFrequentie) {
//    hoogsteFrequentie = frequentie;
//    spelFrequentie = hoogsteFrequentie;
//  }
//}

/*
void berekenKaartKleur() {
 kaartKleur = new int[plekkenMetKaart.length][plekkenMetKaart[0].length];
 for (int i = 0; i < kaartKleur.length; i++) {
 for (int j = 0; j < kaartKleur[i].length; j++) {
 kaartKleur[i][j] = int(random(1, (aantalSetjes) + 1));
 kaartKleur[i][j] = kaartKleur[i][j] - 1;
 //println(kaartKleur[i][j]);
 int kleurFrequentie = 0;
 kleurennummers.println(kaartKleur[i][j]+" "+"Is_gegenereerd");//
 for (int k = 0; k < kaartKleur.length; k++) {
 for (int l = 0; l < kaartKleur[k].length; l++) {//gaat de hele rij af om te kijken of de kleur al 2x bestaat.
 kleurennummers.println("Check_cijfer:"+kaartKleur[k][l]+ " checkt dit cijfer:"+kaartKleur[i][j]);
 if (kaartKleur[k][l] == kaartKleur[i][j]) {
 kleurFrequentie++;
 kleurennummers.println("KleurFrequentie: ("+kleurFrequentie+")");
 // kleurennummers.println("Frequentie" + kleurFrequentie+ " " + kaartKleur[i][j]);
 if (kleurFrequentie >= 3 && j > 0) {
 kleurFrequentie = 0;
 j -=1;
 kleurennummers.println("J is in de MIN gegaan.");
 }
 }
 }
 }
 }
 kaartPlekkenZijnBerekend = true;
 }
 kleurennummers.println("Klaar");
 kleurennummers.flush();
 kleurennummers.close();
 }
 */
