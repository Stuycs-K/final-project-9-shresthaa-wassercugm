public class CueBall extends Ball {
  PVector direction, force; //start direction, will be implemented with spin

  public CueBall(int x, int y, boolean stripe, int num) { //constructor
    super(x, y, stripe, num);
    force = new PVector(0, 0);
    vel = new PVector(0, 0);
  }
  
  void applyFriction() {
    force.div((float)m);
    acc.add(force);
    move();
  }

  void press(int x, int y) {
    if (aimBall == 0) {
      setD(getP().sub(new PVector(x, y)).normalize());
      aimBall++;
    } else if (aimBall == 1) {
      setS(count);
      aimBall++;
    } else if (aimBall == 2) {
      if (ready) {
        cue.aim();
        aimBall = 0;
        //ready = false;
      } else {
        System.out.print("wait until simulation movement ends");
      }
    }
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

  void setS(float s) {
    /*double mag = mu * m * G;
    PVector force = PVector.mult(vel, -1);
    force.normalize();
    force.mult( (float) mag );*/
    force = PVector.mult(direction, s);
  }
}
