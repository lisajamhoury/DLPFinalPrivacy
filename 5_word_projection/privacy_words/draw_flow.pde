

// Collect setup functions for draw functions here 
void setupDrawText() {
  setupVehicles();

}


//////////////// EMG VARIABLES ////////////////
import java.util.Iterator;

//DEBUG
boolean debugFrameRate = true;
boolean debugFlowField = false;

//Set noise for each flowfield
int noise1 = 7;
int noise2 = 14;

FlowField flowfield1; // field for left emg sensors of both performers
//FlowField flowfield2; // field for right emg sensors of both performers
ArrayList<Magnet> magnet;
boolean emgRunning = true;

ArrayList<Vehicle> vehicles;
PVector vStart;

float minSpeed =  0.00000007; //0.00000030;
float maxSpeed = 4*minSpeed;
float force = 0.0000001;

// to control which part of emg sketch is drawn
int emgState = 0;

void setupVehicles() {
  noiseSeed(noise1); // 7 ok, but a bit too noisy on right
  
  flowfield1 = new FlowField(resolution); // resolution declared globally
  magnet = new ArrayList<Magnet>(); 
  flowfield1.init();

  PVector magnetPos = new PVector(CTR.x, 1.25 * CTR.y);
  flowfield1.update(magnetPos);
  
  
  vehicles = new ArrayList<Vehicle>();

  float vX = 0;
  float vY = 0.5 * height;
  
  vStart = new PVector(vX, vY);
  
}

void drawVehicles() {
  emgRunning = true;
  addEmgVehicles();
  runEmgVehicles();
  if (debugFrameRate == true) {
    debugFrameRate();
  }

  //if (debugFlowField == true) {
  //  debugFlowField();
  //}
}


void addEmgVehicles() {  
  vStart.x = random(width);
  vStart.y = random(height);
  //String newPhrase = "taco";
  String newPhrase = getPhrase();
  vehicles.add(new Vehicle(newPhrase, vStart.x, vStart.y, random(AREA*minSpeed, AREA*maxSpeed), random(AREA*force)));

}


String getPhrase() {
 //String phrase = "taco";
 String phrase;
 int lineNo = floor(random(lines.length-1));
 //Sentence s = displaySentences.get(phraseNo);
 phrase = lines[lineNo]; 
 return phrase;
  
}

void runEmgVehicles() {
  runVehiclesIterator(flowfield1, vehicles, vStart, "left");
  //runVehiclesIterator(flowfield2, vehicles1R, v1RStart, "left");
  //runVehiclesIterator(flowfield1, vehicles2L, v2LStart, "right");
  //runVehiclesIterator(flowfield2, vehicles2R, v2RStart, "right");
}

void runVehiclesIterator(FlowField flowField, ArrayList<Vehicle> vehicles, PVector startPos, String screenSide) {
  if (emgRunning == true) {
    //Draw all vehicles on syphon canvas
    syphonCanvas.beginDraw();
    syphonCanvas.background(0);
    Iterator<Vehicle> it = vehicles.iterator();
    while (it.hasNext()) {
      Vehicle v = it.next();
      v.follow(flowField);
      v.run(syphonCanvas);
      if (v.isDead()) {
        if (screenSide == "left") {
          if (v.position.x > CTR.x) {
            PVector reStart = new PVector(0, random(height));
            startPos.set(reStart);
          } else {
            startPos.set(v.position);
          }
        }
        //startPos = v.position.copy(); 
        //startPos.set(v.position);
        it.remove();
      }
    }
  syphonCanvas.endDraw();
  }
}



void debugFrameRate() {
  //FRAMERATE BOX
  syphonCanvas.beginDraw();
  syphonCanvas.colorMode(RGB);
  syphonCanvas.fill(255, 0, 0);
  syphonCanvas.rect(0, 0, 100, 100);
  syphonCanvas.fill(255);
  syphonCanvas.text(floor(frameRate), 10, 40);
  syphonCanvas.endDraw();

  //vehicle array size debug
  //text(floor(vehicles1L.size()), 10, 60);
  //text(floor(vehicles1R.size()), 10, 80);
  //text(floor(vehicles2L.size()), 10, 100);
  //text(floor(vehicles2R.size()), 10, 120);
}

void debugFlowField() {
  flowfield1.display();
  //flowfield2.display();

  Iterator<Magnet> it = magnet.iterator();
  while (it.hasNext()) {
    Magnet m = it.next();
    m.display();
  }
}


//////////////// END EMG VEHICLES ////////////////