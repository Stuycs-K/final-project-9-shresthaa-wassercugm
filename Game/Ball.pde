public class Ball {
  PVector pos, vel, acc;
  color col;
  // int numBall;
  //note: cueball has m = 0.17
  // double friction;
  //when moving cueball = up to 0.7!
  // boolean onBoard = true;
  

  public Ball(int x, int y) { //constructor
    pos = new PVector(x,y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    col = color(random(255), random(255), random(255));
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
  
  void goal(){
    
  }
  
  void removeBall(){
    
  }
  

  PVector getP() {
    return pos;
  }
  
  PVector getV() {
    return vel;
  }
  
  
  
}
