boolean doodsKaarten;
int scherm;
final int START_SCHERM = 0;
final int SPEL_SCHERM = 1;
final int EIND_SCHERM = 2;
final int HOEK_RADIUS = 20;
final int TEKST_KLEUR = #FFFFFF;
final int WIT = #FFFFFF;
final int ROOD = #FF0000;
final int GROEN = #00FF00;
final int BLAUW = #0000FF;
final int GRIJS = #AAAAAA;
final int GEEL = #FFFF00;
final int ORANJE = #FFA500;
final int PAARS = #800080;
final int CYAAN = #00FFFF;
final int ROZE = #FFC0CB;
final int BRUIN = #654321;
final int DONKERROOD = #8B0000;
final int DONKERBLAUW = #00008B;
final int DONKERGROEN = #008B00;
final int ZANDBRUIN = #F4A460;
final int KLEUR_DOODSKAARTEN = #FF0000;
final int LICHT_BLAUW = #ADD8E6;
final int BOSGROEN = #228B22;
final int CEMENTGRIJS = #7D8471;
final int MIDDENVIOLETROOD= #C71585;
final int LEIGRIJS = #708090;
final int DIEPROZE= #FF1493;
final int ACHTERKANT_VAN_KAART_KLEUR = 0;


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
