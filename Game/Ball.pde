public class Ball {
  PVector pos, vel, acc;
  color col;
  int numBall;
  boolean onBoard = true;
  boolean isStriped;
  final double m = 0.16; //kilograms
  final double mu = 0.06;
  final double G = 1.07;


  public Ball(float x, float y, boolean stripe, int num) { //constructor
    pos = new PVector(x, y);
    vel = new PVector(-5, 5);
    acc = new PVector(0, 0);
    isStriped = stripe;
    numBall = num;
    col = color(random(255), random(255), random(255));
    if (col == color(41, 163, 33)) {
      col = color(244, 7, 7);
    }
    //restrict green color from appearing and camouflage into background
  }
  
  public Ball(float x, float y, float xv, float yv, boolean stripe, int num) { //constructor
    pos = new PVector(x, y);
    vel = new PVector(xv, yv);
    acc = new PVector(0, 0);
    isStriped = stripe;
    numBall = num;
    col = color(random(255), random(255), random(255));
    if (col == color(41, 163, 33)) {
      col = color(244, 7, 7);
    }
    //restrict green color from appearing and camouflage into background
  }

  void collide(Ball other){
    //float angle = (float) Math.atan( (other.pos.y - pos.y) - (other.pos.x - pos.x) );
    //PVector newVA = vel.rotate(angle);
    //PVector newVB = other.vel.rotate(angle);
    //float temp = newVA.x;
    //newVA.x = newVB.x;
    //newVB.x = temp;
    //vel = newVA.rotate(-angle);
    //other.vel = newVB.rotate(-angle);
    
    //// A : this
    //// B : other
    //PVector V0 = PVector.sub(vel, other.vel);

    //PVector newVB = new PVector(other.pos.x-pos.x, other.pos.y-pos.y);
    //newVB.normalize();
    
    //float angle = PVector.angleBetween(V0, newVB);
    //PVector newVA = V0.rotate(PI/2-angle);
    //newVA.normalize();
    
    //double magA = V0.mag() * Math.sin(angle);
    //double magB = V0.mag() * Math.cos(angle);
    
    //newVA.mult((float)magA);
    //newVB.mult((float)magB);
    //newVA.add(other.vel);
    //newVB.add(other.vel);
    
    //vel = newVA;
    //other.vel = newVB;
        
  }

  void move() {
    vel.add(acc);
    pos.add(vel);
    acc.set(0, 0);
    
    // bouncing
    if (pos.x>=width-border-r||pos.x<=border+r) { 
      vel.x *= -1;
    }
    if (pos.y>=height-border-r||pos.y<=border+r) {
      vel.y *= -1;
    }
    
    // preventing high velocity balls from drawing on the border
    if (pos.x < r+border){ pos.x = r+border; }
    if (pos.x > width-border-r){ pos.x = width-border-r; }
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
      stroke(0);
      fill(col);
      circle(pos.x, pos.y, (float)r*2);
      fill(255);
      noStroke();
      circle(pos.x, pos.y, (float)r);
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
    double x = Math.pow(pos.x-other.pos.x, 2);
    double y = Math.pow(pos.y-other.pos.y, 2);
    double dist = Math.sqrt(x+y);
    return dist <= 2*r;
  }
  
  void setVel(float x, float y) {
    vel.set(x,y);
  }
  
  PVector getP() {
    return pos;
  }

  PVector getV() {
    return vel;
  }
}
