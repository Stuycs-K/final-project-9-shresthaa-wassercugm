ArrayList<Ball> balls;
CueBall cue = new CueBall(500, 500);
final int r = 16;
int boardWidth;
int boardHeight;
int border;
int aimBall;
int ballStop;
PVector endMouse;


void drawTable() {
  stroke(0);
  fill(122, 72, 38);
  rect(0, 0, width, height);
  fill(41, 163, 33);
  rect(border, border, boardWidth, boardHeight);
}

void setup() {
  size(1100, 600);
  boardWidth = 1000;
  boardHeight = 500;
  border = 50;

  balls = new ArrayList<Ball>();
  balls.add(cue);
  aimBall = 0;
  ballStop = 1;

  //other
  textAlign(CENTER);

  // draw table
  drawTable();
}


boolean canPlace(Ball aBall) {
  for (Ball ball : balls) {
    if (aBall.isOverlapping(ball)) {
      return false;
    }
  }
  return true;
}

void mouseReleased() {
  if (aimBall == 1 && ballStop == balls.size()) {
    cue.setD(PVector.sub(endMouse, new PVector(mouseX, mouseY)));
    aimBall++;
  }
}

void mouseDragged() {
  if(aimBall == 0 && ballStop == balls.size()){
    endMouse = new PVector(mouseX, mouseY);
    aimBall ++;
  }else if (ballStop == balls.size()&&aimBall==2) {
    aimBall = 0;
  } else {
    System.out.print("wait until simulation movement ends");
  }
}

void mouseClicked() {
  if (aimBall == 2) {
    int x = mouseX;
    int y = mouseY;
    if (x < border+r) {
      x = border+r;
    }
    if (x > width-border-r) {
      x = width-border-r;
    }
    if (y < border+r) {
      y = border+r;
    }
    if (y > height-border-r) {
      y = height-border-r;
    }

    boolean stripe = true;
    if (Math.random() < 0.5) {
      stripe=false;
    }
    Ball toAdd = new Ball(x, y, stripe, balls.size());

    if (canPlace(toAdd)) {
      balls.add(toAdd);
    }
  }
}

void draw() {
  drawTable();


  for (int i=0; i < balls.size(); i++) {
    Ball ball = balls.get(i);

    if ((ballStop == balls.size()&&aimBall!=1) || (abs( cue.getV().x ) < 0.1 && abs( cue.getV().y ) < 0.1 )) {
      cue.setVel(0, 0);
      aimBall = 0;
      ballStop = 0;
    }

    if (abs( ball.getV().x ) < 0.1 && abs( ball.getV().y ) < 0.1 ) {
      if (i == 0 && aimBall == 2) {
        aimBall = 0;
        ball.setVel(0, 0);
        ballStop++;
      } else if (i != 0 && ball.getV()!=new PVector(0,0)) {
        ball.setVel(0, 0);
        ballStop++;
      }
    } else {
      ball.applyFriction(ball.getForce());
    }

    for (int j = i+1; j < balls.size(); j++) {
      Ball other = balls.get(j);
      if (ball.isOverlapping(other)) {
        ball.collide(other);
      }
    }

    ball.move();
    ball.getShape();
  }
}
