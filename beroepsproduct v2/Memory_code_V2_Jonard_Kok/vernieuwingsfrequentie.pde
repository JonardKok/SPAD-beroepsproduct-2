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
