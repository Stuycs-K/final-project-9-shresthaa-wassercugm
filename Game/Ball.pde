public abstract class Ball {
  PVector pos, vel, acc;
  color col;
  int numBall;
  final double r = 16;
  final double m = 0.16; //kilograms
  //note: cueball has m = 0.17
  double friction;
  boolean onBoard = true;
  

  void Ball() { //constructor
  }

  void collision(int numBalls, PVector direction, ArrayList<Ball> other) {
  }

  void move() {
  }

  void applyFriction() {
  }

  void getShape() {
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
