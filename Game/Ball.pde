public abstract class Ball {
  PVector pos, vel, acc;
  color col;
  int numBall;
  final double r = 16;
  final double m = 0.16; //kilograms
  //note: cueball has m = 0.17
  double friction;
  //when moving cueball = up to 0.7!
  boolean onBoard = true;
  

  void Ball(int x, int y) { //constructor
    pos = new PVector(x,y);
    //vel = new PVector(0,0);
    if(x-16<=50){
        x = 16+1;
      }else if(x+16>=750){
        x = 750-16-1;
      }
      if(y-16<=50){
        y = 16+1;
      }else if(y+16>=1450){
        y = 1450-16-1;
      }
  }

  void collision(int numBalls, PVector direction, ArrayList<Ball> other) {
    //friction = 0.06; //ignore for mvp
    
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
