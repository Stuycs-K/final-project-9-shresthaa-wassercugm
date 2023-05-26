public class CueBall extends Ball {

  public CueBall(float x, float y) { //constructor
    super(x, y, false, -1);
    vel = new PVector(0, 0);
  }


  void getShape() {
    stroke(0);
    fill(255);
    circle(pos.x, pos.y, (float)r*2);
  }


  void setP(PVector p) {
    pos = p;
  }

  void setD(PVector d) {
    vel = d;
  }
}
