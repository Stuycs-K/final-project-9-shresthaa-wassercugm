public class Ball {
  PVector pos, vel, acc;
  //default acc = (1,1)
  color col;
  // int numBall;
  // restrict numBall so doesn't overflow for mvp
  //note: cueball has m = 0.17
  // double friction;
  //when moving cueball = up to 0.7!
  boolean onBoard = true;


  public Ball(int x, int y) { //constructor
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(1, 1);
    /*float r = random(255);
     float g = random(255);
     float b = random(255);
     if (g > (r+b)*3/2) {
     g = g/2;
     }*/
    col = color(random(255), random(255), random(255));
    if (col == color(41, 163, 33)) {
      col = color(244, 7, 7);
    }
    //restrict green color from appearing and camouflage into background
  }
  
  void setVel(PVector v){
    vel = v;
  }

  void collision(int numBalls, PVector direction, ArrayList<Ball> other) {
    //friction = 0.06; //ignore friction for mvp
    
  }

  void move() {
    pos.x += vel.x + acc.x; //speed
    pos.y += vel.y + acc.y;
    acc.x += 1; //default value
    acc.y += 1; //default value
    if (pos.x>=width-border-r||pos.x<=border+r) { //bounce
      vel.x *= -1;
    }
    if (pos.y>=height-border-r||pos.y<=border+r) {
      vel.y *= -1;
    }
    
    //applyFriction();
  }

  void applyFriction() {
  }

  void getShape() {
    if (onBoard) {
      fill(col);
      stroke(0);
      circle(pos.x, pos.y, (float)r*2);
      noStroke();
      noFill();
    }
  }

  void goal() {
    onBoard = false;
  }

/*  void removeBall() {
  //use onBoard in getShape, unnecessary?
  }*/


  PVector getP() {
    return pos;
  }

  PVector getV() {
    return vel;
  }
}
