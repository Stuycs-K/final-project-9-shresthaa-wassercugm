public class CueBall extends Ball{
  PVector direction; //start direction, will be implemented with spin
  double strength;
  
  public CueBall(int x, int y, boolean stripe, int num) { //constructor
    super(x,y,stripe,num);
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
