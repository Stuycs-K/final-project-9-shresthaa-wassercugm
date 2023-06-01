ArrayList<Ball> balls;
CueBall cue;
final int r = 16;

// for drawing the table (dimensions)
int boardWidth;
int boardHeight;
int border;
int sideBar;

// for user interaction
boolean canShoot;
int template = 0;
float strength = 500;
PVector aimDirection; // should be kept normalized
Controller keyboardInput;

void drawTable() {
  stroke(0);
  fill(122, 72, 38);
  rect(0, 0, boardWidth+2*border, boardHeight+2*border);
  fill(0);
  
  ////Upper left hole
  //translate(border,border);
  //rotate(-PI/6);
  //ellipse(0, 0, 50, 60);
  //rotate(PI/6);
  //translate(-border,-border);
  
  ////Upper right hole
  //translate(boardWidth+border,border);
  //rotate(PI/6);
  //ellipse(0, 0, 50, 60);
  //rotate(-PI/6);
  //translate(-boardWidth-border,-border);
  
  ////Bottom left hole
  //translate(border,boardHeight+border);
  //rotate(PI*7/6);
  //ellipse(0, 0, 50, 60);
  //rotate(-PI*7/6);
  //translate(-border,-boardHeight-border);
  
  ////Bottom right hole
  //translate(boardWidth+border,boardHeight+border);
  //rotate(PI*10/6);
  //ellipse(0, 0, 50, 60);
  //rotate(-PI*10/6);
  //translate(-boardWidth-border,-boardHeight-border);
  
    //Upper middle hole
  ellipse(boardWidth/2+border,border-5, 55, 60);
  
  //Bottom middle hole
  ellipse(boardWidth/2+border,boardHeight+border+5, 55, 60);
  
  fill(41, 163, 33);
  rect(border, border, boardWidth, boardHeight);
  noFill();
  
  stroke(255);
  line(50,85,85,50);
  line(50,515,85,550);

}

void powerBar() {
  fill(255);
  textSize(25);
  text("power", 1150, 50);

  noStroke();
  color c1 = color(255, 0, 0);
  color c2 = color(0, 255, 0);
  for (float i = 0; i <= 1; i += 0.01) {
    fill( lerpColor(c1, c2, i) );
    
    rect(1125, 100 + 400 * i, 50, 4);
  }
}

void setup() {
  size(1200, 600);
  background(0);
  boardWidth = 1000;
  boardHeight = 500;
  border = 50;
  sideBar = 100;

  balls = new ArrayList<Ball>();
  cue = new CueBall(550, 300);
  balls.add(cue);

  //other
  textAlign(CENTER);

  canShoot = false;

  aimDirection = new PVector(0, 1).normalize();

  keyboardInput = new Controller();

  // draw table
  drawTable();
  // draw power bar
  powerBar();
}

boolean canPlace(Ball aBall) {
  for (Ball ball : balls) {
    if (aBall.isOverlapping(ball)) {
      return false;
    }
  }
  return true;
}

boolean mouseOnTable(){
  return mouseX > border && mouseX < boardWidth + border && mouseY > border && mouseY < boardHeight + border;
}

void mouseClicked() {
  if (template!=1 && mouseOnTable()) {
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

void mouseDragged() {
  if (canShoot) {
    if (mouseX < boardWidth + 2*border) {
      aimDirection = new PVector(mouseX - cue.getP().x, mouseY - cue.getP().y);
      aimDirection.normalize();
    } else if (mouseX > 1125 && mouseX < 1175 && mouseY > 100 && mouseY < 500) {
      strength = mouseY;
    }
  }
}

void drawArrow() {
  strokeWeight(4);
  stroke(0);
  float x1 = cue.getP().x;
  float y1 = cue.getP().y;
  float x2 = x1 + aimDirection.x*100;
  float y2 = y1 + aimDirection.y*100;
  line(x1, y1, x2, y2);
  PVector normal = aimDirection.copy();
  normal.rotate(PI/2);
  fill(0);
  triangle( x1 + aimDirection.x*110, y1 + aimDirection.y*110,
    x2 + normal.x*5, y2 + normal.y * 5,
    x2 - normal.x*5, y2 - normal.y * 5
    );
  strokeWeight(1);
}

void keyPressed() {
  keyboardInput.press(keyCode);
}

void keyReleased() {
  keyboardInput.release(keyCode);
}

void draw() {
  background(0);
  powerBar();
  drawTable();
  int stopped = 0;
  
  if (canShoot&&keyboardInput.isPressed(2)&&template==1) {
    keyboardInput.release(2);
    template = 0;
    balls = new ArrayList<Ball>();
    //cue = new CueBall(550, 300);
    balls.add(cue);
  }

  //default pool start template(9 balls), can't create own balls
  if (canShoot&&keyboardInput.isPressed(1)&&template!=1) {
    keyboardInput.release(2);
    balls = new ArrayList<Ball>();
    cue = new CueBall(border+boardWidth/4, height/2);
    balls.add(cue);
    balls.add(new Ball(width-sideBar-border-boardWidth/4-r/2-7, height/2+6, false, 1));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+r*sin(PI/6)-r/2-2, height/2+r/2+sin(PI/3)*r-r/2, true, 2));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+r*sin(PI/6)-r/2+4, height/2-r/2-sin(PI/3)*r+r/2-2, false, 3));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+2*r*sin(PI/6)+r+1, height/2+1, false, 8));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+2*r*sin(PI/6)+r, height/2+r/2+sin(PI/3)*2*r+1, false, 5));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+2*r*sin(PI/6)+r, height/2-r/2-sin(PI/3)*2*r+2, true, 6));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+3*r*sin(PI/6)+2*r+5, height/2+r/2+sin(PI/3)*r-r/2+6, false, 7));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+3*r*sin(PI/6)+2*r+5, height/2-r/2-sin(PI/3)*r+r/2-2, true, 4));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+3*r*sin(PI/6)+2*r+4, height/2+r/2+sin(PI/3)*3*r+5, true, 10));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+3*r*sin(PI/6)+2*r+5, height/2-r/2-sin(PI/3)*3*r-1, false, 9));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+4*r*sin(PI/6)+3*r+9, height/2+1, false, 11));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+4*r*sin(PI/6)+3*r+9, height/2+r/2+sin(PI/3)*2*r+1, false, 13));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+4*r*sin(PI/6)+3*r+9, height/2-r/2-sin(PI/3)*2*r+2, true, 12));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+4*r*sin(PI/6)+3*r+9, height/2+r/2+sin(PI/3)*4*r+1, true, 14));
    balls.add(new Ball(width-sideBar-border-boardWidth/4+4*r*sin(PI/6)+3*r+9, height/2-r/2-sin(PI/3)*4*r+1, false, 15));
    keyboardInput.release(1);
    template = 1;
  }


  if (canShoot) {
    // reset cue ball
    if (!cue.isOnBoard()){
      cue.reset();
    }
    
    // draw aiming arrow
    drawArrow();
    
    // draw marker on power bar
    fill(157, 5, 240);
    rect(1120, strength, 60, 8, 4);
    
    // fire when enter is pressed
    if (keyboardInput.isPressed(Controller.enter)) {
      float power = (400 - (strength-100) )*0.0375 + 5;
      cue.setV( aimDirection.mult(power) );
      canShoot = false;
    }
  }


  for (int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    
    if (ball.isOnBoard()){
      // apply collisions
      for (int j = i+1; j < balls.size(); j++) {
        Ball other = balls.get(j);
        if (ball.isOverlapping(other)) {
          ball.collide(other);
        }
      }
  
      // If the ball is moving, apply friction
      if ( ball.getV().mag() < 0.05 ) {
        ball.setV(0, 0);
        stopped++;
      } else {
        ball.applyFriction(ball.getForce());
      }
  
      ball.changeOnBoard();
      ball.move();
      ball.getShape();
    }else{
      stopped++;
    }
  }

  if (stopped == balls.size()) {
    canShoot = true;
  }
}
