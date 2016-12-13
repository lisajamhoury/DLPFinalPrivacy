//GRID 
int resolution;
int columns;
int rows;

//POSTIONING
PVector CTR;
float AREA;


void setupGlobals() {   
  //resolution = floor(width/180); // scale resolution to canvas size 
  resolution = 20;
  println("resolution", resolution);
  columns = width / resolution;
  rows = height / resolution;  
  
  CTR = new PVector(width/2, height/2);
  AREA = width * height;
}