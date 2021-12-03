boolean doodsKaarten;
int scherm;
final int START_SCHERM = 0;
final int SPEL_SCHERM = 1;
final int EIND_SCHERM = 2;
final int HOEK_RADIUS = 20;
final int TEKST_KLEUR = #FFFFFF;


void setup() {
  //pakVernieuwingsFrequentie();
  fullScreen(FX2D);
  //frameRate(spelFrequentie);
  textAlign(TOP, LEFT);
}
void draw() {
  clear();
  noStroke();
  switch (scherm) {
  case START_SCHERM:
    tekenStartScherm();
    break;
  case SPEL_SCHERM: 
    tekenSpelScherm();
    break;
  case EIND_SCHERM:
    tekenEindScherm();
    break;
  }
}

void mouseClicked() {
  if (scherm == START_SCHERM) {
    veranderStartScherm();
  } else if (scherm == SPEL_SCHERM) {
    veranderSpelScherm();
  }
}
