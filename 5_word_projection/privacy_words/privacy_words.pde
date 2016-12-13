import codeanticode.syphon.*;
import rita.*;

boolean debugFR = false;

PGraphics syphonCanvas;
SyphonServer server;

String dataPath = "data/";
String[] lines;
ArrayList<String> questions = new ArrayList();

ArrayList<Sentence> allSentences = new ArrayList();
ArrayList<Sentence> displaySentences = new ArrayList();

int textSz = 9; // set initial text size

void settings() {
  //size(1280, 720, P3D); // 16 x 9
  size(1024, 576, P3D); // 16 x 9
  PJOGL.profile=1; // best ogl setting for syphon
}

void setup() {
  //create syphon server 
  server = new SyphonServer(this, "Text Projection");

  //setup syphon canvas
  syphonCanvas = createGraphics(width, height, P3D);
  syphonCanvas.beginDraw();
  syphonCanvas.background(0);
  syphonCanvas.endDraw();

  frameRate(30);

  setupGlobals();
  setupDrawText();
  loadText("urls.txt");
}

void draw() {
  background(0);
  if (drawText == true) {
    syphonCanvas.beginDraw();
    syphonCanvas.textSize(textSz);
    drawVehicles();

    if (debugFR == true) {
      println("debug");
      syphonCanvas.colorMode(RGB);
      syphonCanvas.fill(255, 0, 0);
      syphonCanvas.rect(0, 0, width, height);
      syphonCanvas.fill(255);
      syphonCanvas.text(floor(frameRate), 10, 40);
    }

    syphonCanvas.endDraw();

    //displayText();
    if (debugFlowField == true) {
      debugFlowField();
    }
  
 
}

  image(syphonCanvas, 0, 0);
  server.sendImage(syphonCanvas);
}

void displayText() {
  for (int i = 0; i < displaySentences.size()/4; i++) {
    Sentence s = displaySentences.get(i);
    //text(s.text, 50, 50 + (i * 20));
    text(s.text, random(width), random(height));
  }
}


void loadText(String corpus) {
  String url = dataPath + corpus;
  lines = loadStrings(url);
}