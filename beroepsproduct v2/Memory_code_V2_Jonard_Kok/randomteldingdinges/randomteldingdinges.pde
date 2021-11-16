int araryLengte = 40;
int[] lijst = new int[araryLengte];
int getal = 0;
for (int i = 0; i < lijst.length; i++) {
  getal++;
  int cijfer = int(random((araryLengte/2) + 1));
  int cijferkomtvoor = 0;
  for (int j = 0; j < lijst.length; j++) {
    if (lijst[i] != 0 && lijst[j]==lijst[i]) {
      cijferkomtvoor++;
      println("cijfer", cijfer);
      println("cijferkomtvoor", cijferkomtvoor);
      println("lijst[j]" + lijst[j], "lijst[i]" + lijst[i]);
    }
    if (cijferkomtvoor >= 2) {
      if (i > 0) {
        i--;
        getal--;
        cijferkomtvoor = 0;
        println("i:", i);
      }
    }
    println("lijst[j]: " + lijst[j], "lijst[i]: " + lijst[i], "i: " + i);
  }
  lijst[i] = cijfer; 
  println("lijst[i]"+ lijst[i], "getal"+ getal);
}
exit();

/*
lijst i maakt eerste getal
 lijst j gaat lijst i af om te kijken hoevaak het getal voorkomt. //hier fout
 */
