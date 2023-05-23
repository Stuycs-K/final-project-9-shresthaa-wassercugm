public class Ball {
  PVector pos, vel, acc;
  color col;
  int numBall;
  //note: cueball has m = 0.17
  // double friction;
  //when moving cueball = up to 0.7!
  boolean onBoard = true;
  boolean isStriped;


  public Ball(int x, int y, boolean stripe, int num) { //constructor
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

  void collision(int numBalls, PVector direction, ArrayList<Ball> other) {
    //friction = 0.06; //ignore friction for mvp
    
  }

  void move() {
    pos.x += vel.x; //speed
    pos.y += vel.y;
    if (pos.x>=width-border-r||pos.x<=border+r) { //bounce
      vel.x *= -1;
      //acceleration/deceleration here w/ impact of wall on velocity
    }
    if (pos.y>=height-border-r||pos.y<=border+r) {
      vel.y *= -1;
      //accelerate!
    }
    //applyFriction();
  }

  void applyFriction() {
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

  PVector getP() {
    return pos;
  }

  PVector getV() {
    return vel;
  }
  
  boolean isOverlapping(Ball other){
    double x = Math.pow(pos.x-other.pos.x, 2);
    double y = Math.pow(pos.y-other.pos.y, 2);
    double dist = Math.sqrt(x+y);
    return dist < 2*r;
  }
}
