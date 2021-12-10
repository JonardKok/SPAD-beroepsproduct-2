final int START_SCHERM = 0;
final int SPEL_SCHERM = 1;
final int EIND_SCHERM = 2;
int scherm;
//int scherm = EIND_SCHERM;

void setup() {
  fullScreen();
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
  switch (scherm) {
  case START_SCHERM:
    veranderSpelInstellingen();
    break;
  case SPEL_SCHERM:
    kaartKlikActies();
    break;
  case EIND_SCHERM:
    eindSchermActies();
    break;
  }
}
