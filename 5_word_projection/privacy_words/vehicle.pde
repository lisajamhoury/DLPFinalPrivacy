class Vehicle {
  PVector position;
  PVector acceleration;
  PVector velocity;
  float r;
  float maxspeed;
  float maxforce;
  float lifespan = 10;
  float vBright; 
  //color clr;
  float lineStk = 0.0000004 * AREA;
  ArrayList<PVector> prevPositions;
  boolean wrapping = false;
  String vLogic;
  String phrase;
  PGraphics canvas;

  PVector prevPos;

  Vehicle(String iPhrase, float x, float y, float ms, float mf) {
    phrase = iPhrase;
    position = new PVector(x, y);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    r = 4;
    maxspeed = ms;
    maxforce = mf;
    vBright = 255;
    //vLogic = iLogic; 
    //clr = iClr;

    prevPositions = new ArrayList<PVector>();  
    prevPos = position.copy();
  }

  void run(PGraphics iCanvas) {
    canvas = iCanvas;
    update();
    //borders();
    display();
  }

  void follow(FlowField flow) {
    PVector desired = flow.lookup(position);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    //v1Start = position;
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= 0.1;

    prevPos = position.copy();
    prevPositions.add(prevPos);

    // check if there's more than one vertex in the vehicle & that wrapping is false
    if (prevPositions.size() > 1 && wrapping == false) {
      //check to see if vehicle is wrapping  
      int prevPosSize = prevPositions.size(); 
      PVector point1 = prevPositions.get(prevPosSize-1);
      PVector point2 = prevPositions.get(prevPosSize-2);
      float diff = abs(point1.y-point2.y);
      //if wrapping set wrapping true
      if (diff > height/2) {
        wrapping = true;
      }
    }
  }

  void borders() {

  }

  void display() {
    canvas.fill(255);
    canvas.text(phrase, position.x, position.y);
  }
  
  boolean isDead() {
    if (position.x < -r) return true;
    if (position.y < -r) return true;
    if (position.x > width+r) return true;
    if (position.y > height+r) return true;

    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}