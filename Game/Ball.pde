public class Ball { //<>// //<>//
  PVector pos, vel, acc;
  color col;
  int numBall;
  boolean onBoard = true;
  boolean isStriped;
  final double m = 0.16; //kilograms
  final double mu = 0.06;
  final double G = 1.07; 
  
  public Ball(float x, float y, boolean stripe, color c, int num){
    pos = new PVector(x,y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    isStriped = stripe;
    col = c;
    numBall = num;
  }

  public Ball(float x, float y, boolean stripe, int num) { //constructor
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    isStriped = stripe;
    numBall = num;
    col = color(random(255), random(255), random(255));
    if (col == color(41, 163, 33)) {
      col = color(244, 7, 7);
    }
    //restrict green color from appearing and camouflage into background
  }
  
  // for testing purposes
  public Ball(float x, float y, float vx, float vy, boolean stripe, int num) { //constructor
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    acc = new PVector(0, 0);
    isStriped = stripe;
    numBall = num;
    col = color(random(255), random(255), random(255));
    if (col == color(41, 163, 33)) {
      col = color(244, 7, 7);
    }
    //restrict green color from appearing and camouflage into background
  }
  
  void fixOverlap(Ball other){
    float overlap = 2*r - this.pos.dist(other.pos);
    float dx = other.pos.x - this.pos.x;
    float dy = other.pos.y - this.pos.y;
    PVector fixOther = new PVector(dx, dy).normalize().mult(overlap/2);
    PVector fixThis = new PVector(-dx, -dy).normalize().mult(overlap/2);
    other.pos.add(fixOther);
    pos.add(fixThis);
  }
  
  

  void collide(Ball other){
    fixOverlap(other);
     
    float dx = other.pos.x - this.pos.x;
    float dy = other.pos.y - this.pos.y;
    float angle = atan2(dy,dx);
    this.vel.rotate(angle);
    other.vel.rotate(angle);
    float temp = this.vel.x;
    this.vel.x = other.vel.x;
    other.vel.x = temp;
    this.vel.rotate(-angle);
    other.vel.rotate(-angle);
        
  }

  void move() {
    vel.add(acc);
    pos.add(vel);
    acc.set(0, 0);
    
    // bouncing
    if (pos.x>=width-border-sideBar-r||pos.x<=border+r) { 
      vel.x *= -1;
    }
    if (pos.y>=height-border-r||pos.y<=border+r) {
      vel.y *= -1;
    }
    
    // preventing high velocity balls from drawing on the border
    if (pos.x < r+border){ pos.x = r+border; }
    if (pos.x > width-border-sideBar-r){ pos.x = width-border-sideBar-r; }
    if (pos.y < r+border){ pos.y = r+border; }
    if (pos.y > height-border-r){ pos.y = height-border-r; } 
    

    //applyFriction();
  }
  
  PVector getForce(){
    double mag = mu * m * G;
    PVector force = PVector.mult(vel, -1);
    force.normalize();
    force.mult( (float) mag );
    return force;
  }


  void applyFriction(PVector f) {
    f.div((float)m);
    acc.add(f);
  }

  void getShape() {
    if (onBoard) {
      // outer circle
      stroke(0);
      fill(col);
      circle(pos.x, pos.y, (float)r*2);
      //inner circle
      fill(255);
      noStroke();
      circle(pos.x, pos.y, (float)r);
      // number
      textSize(12);
      fill(0);
      text(numBall, pos.x, pos.y+r/4);
      if (isStriped){
        stroke(0);
        fill(255);
        arc(pos.x, pos.y, (float)r*2, (float)r*2, PI/4, 3*PI/4, OPEN);
        arc(pos.x, pos.y, (float)r*2, (float)r*2, 5*PI/4, 7*PI/4, OPEN);
      }
    }
  }

  void goal() {
    onBoard = false;
  }
  
  boolean isOverlapping(Ball other){
    double dist = dist(pos.x, pos.y, other.pos.x, other.pos.y);
    return dist < 2*r;
  }
  
  void setV(float x, float y) {
    vel.set(x,y);
  }
  
  void setV(PVector v) {
    vel = v;
  }
  
  PVector getP() {
    return pos;
  }

  PVector getV() {
    return vel;
  }
  
  boolean isOnBoard(){
    return onBoard;
  }
}
