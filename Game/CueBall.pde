public class CueBall extends Ball {
  PVector direction, force; //start direction, will be implemented with spin

  public CueBall(int x, int y) { //constructor
    super(x, y, false, 8);
    force = new PVector(0, 0);
    vel = new PVector(0, 0);
  }
  
  void applyFriction() {
    force.div((float)m);
    acc.add(force);
    move();
  }

  //int press(int x, int y) {
  //  if (aimBall == 0) {
  //    setD(getP().sub(new PVector(x, y)).normalize());
  //  } else if (aimBall == 1) {
  //    setS(count);
  //  } else if (aimBall == 2) {
  //    if (ready) {
  //      cue.aim();
  //      ready = true;
  //    } else {
  //      System.out.print("wait until simulation movement ends");
  //    }
  //  }
  //  return aimBall;
  //}

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
    vel = direction;
    force.normalize();
    force = getForce().mult(s/10);
  }
}
