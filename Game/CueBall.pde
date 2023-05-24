public class CueBall extends Ball{
  PVector direction, f; //start direction, will be implemented with spin
  double strength;
  
  public CueBall(int x, int y, boolean stripe, int num) { //constructor
    super(x,y,stripe,num);
  }
  
  void aim(){
    vel = direction;
    f = strength;
    move();
  }
  
  PVector getForce(){
    double mag = mu * m * G;
    PVector force = PVector.mult(vel, -1);
    force.normalize();
    force.mult( (float) mag );
    return force;
  }
  
  void setP(PVector p){
    pos = p;
  }
  
  void setD(PVector d){
    direction = d;
  }
  
  void setS(double s){
    strength = s;
  }
}
