import java.util.*;

int[] lijst = new int[40];
int getal = 0;
for (int i = 0; i < lijst.length; i++) {
  getal++;
  int cijfer = int(random(20 + 1));

  for (int j = 0; j < lijst.length; j++) {
    List<Integer> intList = new ArrayList<Integer>(lijst.length);
    for (int o : lijst) {
      intList.add(o);
    }

    if (Collections.frequency(intList, getal) == 2 && i > 0) {
      i--;
      println("NEGATIEF");
    }
  }
  lijst[i] = cijfer;
  println("arrayplek: "+ lijst[i], "keer:" + getal);
}
exit();
