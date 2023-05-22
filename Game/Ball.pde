public class Ball {
  PVector pos, vel, acc;
  color col;
  // int numBall;
  //note: cueball has m = 0.17
  // double friction;
  //when moving cueball = up to 0.7!
  // boolean onBoard = true;


  public Ball(int x, int y) { //constructor
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    float r = random(255);
    float g = random(255);
    float b = random(255);
    /*if (g > (r+b)*3/2) {
      g = g/2;
    }*/
    if(col == color(41,163,33)){
      col = color(244,7,7);
    }
    //restrict green color from appearing and camouflage into background??
    col = color(r,b,g);
  }

  void collision(int numBalls, PVector direction, ArrayList<Ball> other) {
    //friction = 0.06; //ignore for mvp
  }

  void move() {
    pos.x += vel.x; //speed
    pos.y += vel.y;
    if(pos.x>=width-border-r||pos.x<=border+r){ //bounce
      vel.x *= -1;
      //acceleration here
    }
    if(pos.y>=height-border-r||pos.y<=border+r){
      vel.y *= -1;
      //accelerate!
    }
  }

  void applyFriction() {
  }

  void getShape() {
    fill(col);
    noStroke();
    circle(pos.x, pos.y, (float)r*2);
  }

  void goal() {
  }

  void removeBall() {

  }


  PVector getP() {
    return pos;
  }

  PVector getV() {
    return vel;
  }
}
