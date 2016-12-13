import codeanticode.syphon.*;

boolean debug = false;

PGraphics syphonCanvas;

SyphonServer server;

ArrayList<Bubble> bubbles;
ArrayList<PImage> faces;

void settings(){
  //size(1280,720, P3D); // 16 x 9
  size(1024,576, P3D); // 16 x 9
  PJOGL.profile=1; // best ogl setting for syphon 
  
}

void setup() {
  syphonCanvas = createGraphics(width, height, P3D);
  //create syphon server 
  server = new SyphonServer(this, "Images and Collage");
  
  syphonCanvas.beginDraw();
  syphonCanvas.background(0);
  syphonCanvas.endDraw();
  
  collageSetup();
  setupAudienceMembers();
 
  noCursor();
  
}

void draw() {
  background(0);
  
  syphonCanvas.beginDraw();
  syphonCanvas.background(0);
  
  if (debug == true) {
    syphonCanvas.fill(255, 0, 0);
    syphonCanvas.rect(0, 0, 100, 100);
    syphonCanvas.fill(255);
    syphonCanvas.text(floor(frameRate), 10, 40);
  }

  syphonCanvas.endDraw();
  
  if (drawPhotos == true) {
    if (addPhotos == true) {
      addPhotosToCollage();
    }
    drawPhotos();
  }
    
  drawAudienceMembers();

  
  image(syphonCanvas, 0, 0);
  server.sendImage(syphonCanvas);
}