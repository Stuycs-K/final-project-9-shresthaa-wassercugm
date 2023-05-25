public class CueBall extends Ball {
  PVector direction, force; //start direction, will be implemented with spin

  public CueBall(int x, int y, boolean stripe, int num) { //constructor
    super(x, y, stripe, num);
    force = new PVector(0,0);
  }

  void aim() {
    vel = direction;
    move();
  }

  void setP(PVector p) {
    pos = p;
  }

  void setD(PVector d) {
    direction = d;
  }

  void setF(PVector f) {
    force = PVector.add(force,f);
  }
}
