class Bubble {
  float x;
  float y;
  PImage img;
  // this.r = 48;
  // this.col = color(255);
  
  Bubble(float iX, float iY, PImage iImg) {
    x = iX;
    y = iY;
    img = iImg;
  }
    
  void update(){
    //x = x + random(-2, 2);
    //y = y + random(-2, 2);    
  }
  
  void display(PGraphics canvas) {
    canvas.stroke(255);
    canvas.fill(255,100);
    //ellipse(this.x,this.y, 48, 48);
    canvas.imageMode(CENTER);
    canvas.image(img, x, y, img.width/4, img.height/4);
  }
  
}