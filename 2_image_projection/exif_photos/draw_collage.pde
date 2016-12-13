int photoExDuration = 3000;
int expandUnits = 10;
int targetBoundX; // set at width and height in setup
int targetBoundY;

int photoExpandUnitX = 20;
int photoExpandUnitY = 20;

int photoIncTimeX = photoExDuration/expandUnits;
int photoIncTimeY = photoExDuration/expandUnits;

int lastPhotoIncX = 0; 
int lastPhotoIncY = 0;

float photoPixelXInc; // number of pixels to expand width each time inc
float photoPixelYInc; // number of pixels to expand height each time inc

int photoTimeElapsedX; // keep time for width expansion
int photoTimeElapsedY; // keep time for height expansion

int photoBoundX = 0; //starting x boundaries
int photoBoundY = 0; //starting y boundaries

int timeAdded = 0; // variable to keep time of most recent collage photo add
int addPhotoInt = 600; // millis interval between added photos 

void collageSetup() {
  String[] filenames = listFileNames(imagePath);
  targetBoundX = width; // how wide collage becomes 
  targetBoundY = height; // how tall collage becomes
  
  photoPixelXInc = targetBoundX/photoExpandUnitX; // how many pixels to increment collage width
  photoPixelYInc = targetBoundY/photoExpandUnitY; // how many pixels to increment collage height
  
  faces = new ArrayList<PImage>();
  bubbles = new ArrayList<Bubble>();
  
  // Load all images in file 
  for(int i = 0; i < filenames.length; i++){
    println(filenames[i]);
    if (filenames[i].equals(".DS_Store")) {  
      
       continue;
    }
   PImage newImage = loadImage(imagePath + "/" + filenames[i]); 
   faces.add(newImage);
  }
}


void addPhotosToCollage() {
  if (millis() > timeAdded + addPhotoInt) {
    int r = floor(random(0,faces.size()));
    PVector newLocation = getNewLocation();
    Bubble b = new Bubble(newLocation.x, newLocation.y, faces.get(r));
    bubbles.add(b);
    timeAdded = millis();
  }
  expandCollageBounds();
}

void drawPhotos() {
  syphonCanvas.beginDraw();
  for(int i = 0; i<=bubbles.size() - 1; i++){
    bubbles.get(i).update();
    bubbles.get(i).display(syphonCanvas);
  }
  syphonCanvas.endDraw(); 
  
}

PVector getNewLocation() {
  PVector loc = new PVector();
  loc.x = width/2 + random(-photoBoundX, photoBoundX);
  loc.y = height/2 + random(-photoBoundY, photoBoundY);
  return loc;
}

void expandCollageBounds() {
 //expand X bounds
 if (millis() > photoIncTimeX + lastPhotoIncX) {
   if (photoBoundX < targetBoundX/2) {
     photoBoundX += photoPixelXInc;
     lastPhotoIncX = millis();
   }
 }

 // expand Y bounds
 if (millis() > photoIncTimeY + lastPhotoIncY) {
   if (photoBoundY < targetBoundY/2) {
     photoBoundY += photoPixelYInc;
     println(photoBoundY);
     lastPhotoIncY = millis();
   } 
 }
}

// This function returns all the files in a directory as an array of Strings (thanks Dan Shiffman!)  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}