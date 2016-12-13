boolean drawText = false;

void keyPressed() {
  if (key == '1') {
    drawText = true;
  }
  
  if (key == 'q') {
    drawText = false;
  }
  
  
  if (key == CODED) {
    if (keyCode == UP) {
      println("u");
      textSz += 1;
    }

    if (keyCode == DOWN) {
      println("d");
      textSz-= 1;
    }
  }
}