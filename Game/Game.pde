ArrayList<Ball> balls; //first ball is cueball!
final int r = 16;
int boardWidth;
int boardHeight;
int border;
Controller clicks;
boolean aimBall = true;
boolean ready;
int count;

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
  
  count = 0;
  balls = new ArrayList<Ball>();
  balls.add(new CueBall(100, 100, false, 8));

  //other
  textAlign(CENTER);

  // draw table
  drawTable();
}

void mousePressed() {
  ready = false;
  clicks.press((CueBall)balls.get(0));
  count += 60;
}

void mouseReleased() {
  clicks.release((CueBall)balls.get(0));
  ready = true;
  count = 0;
}

boolean canPlace(Ball aBall) {
  for (Ball ball : balls) {
    if (aBall.isOverlapping(ball)) {
      return false;
    }
  }
  return true;
}

void mouseClicked() {
  if (ready) {
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
  for (Ball ball : balls) {
    if ( abs( ball.getV().x ) < 0.1 && abs( ball.getV().y ) < 0.1 ){
      ball.setVel(0,0);
    }else{
      ball.applyFriction(ball.getForce());
    }
    ball.move();
    ball.getShape();
  }
}
