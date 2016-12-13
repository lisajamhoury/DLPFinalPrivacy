boolean drawPhotos = false;
boolean addPhotos = false;
boolean am1 = false;
boolean am2 = false;
boolean am3 = false;

void keyPressed() {
  if (key == '1') {
    drawPhotos = true;
    addPhotos = true;
  }

  if (key == 'q') {
    addPhotos = false;
  }

  if (key == 'a') {
    drawPhotos = false;
  }

  if (key == '2') {
    am1 = true;
  }

  if (key == 'w') {
    am1 = false;
  }

  if (key == '3') {
    am2 = true;
  }

  if (key == 'e') {
    am2 = false;
  }

  if (key == '4') {
    am3 = true;
  }

  if (key == 'r') {
    am3 = false;
  }
}