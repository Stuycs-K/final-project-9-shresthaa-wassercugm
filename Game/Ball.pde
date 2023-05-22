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
    color r = color(random(255));
    color g = color(random(255));
    color b = color(random(255));
    if (g > 200 && (r+b) < 200) {
      g = color(200);
    }
    //restrict green color from appearing and camouflage into background
    col = color(r, g, b);
  }

  void collision(int numBalls, PVector direction, ArrayList<Ball> other) {
    //friction = 0.06; //ignore for mvp
  }

  void move() {
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
