ArrayList<Ball> balls;
CueBall cue = new CueBall(500, 500);
final int r = 16;
int boardWidth;
int boardHeight;
int border;
int aimBall = 0;
float count;
boolean ready = true; //indicates player can start aiming
int ballStop;

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
  ballStop = 0;

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
  if (aimBall == 0) {
    aimBall++;
  } else if (ready&&aimBall==2) {
    aimBall = 0;
  }
}

void mousePressed() {
  System.out.println(aimBall);
  if (aimBall == 0) {
    aimBall = cue.press(mouseX, mouseY);
    count += 10;
    if(count > 100){
      count = 1;
    }
    System.out.println(count);
  }
}

void mouseClicked() {
  if (aimBall == 1) {
    aimBall = cue.press(mouseX, mouseY);
    count = 0;
    aimBall++;
    ready = false;
  } else if (aimBall == 2) {
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
  /*if(!ready && ballStop == balls.size()){
    ready = true;
  }*/
  if ((ready&&aimBall!=1) || (abs( cue.getV().x ) < 0.1 && abs( cue.getV().y ) < 0.1 )) {
    cue.setVel(0, 0);
    aimBall = 0;
  } else {
    cue.applyFriction();
  }
  cue.move();
  cue.getShape();
  for (Ball ball : balls) {
    if ( abs( ball.getV().x ) < 0.1 && abs( ball.getV().y ) < 0.1 ) {
      ball.setVel(0, 0);
      ballStop++;
    } else {
      ball.applyFriction(ball.getForce());
      ballStop--;
    }
    ball.move();
    ball.getShape();
  }
}
