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
  
  stroke(255);
  fill(255);
  //upper dots
  quad(boardWidth/8+border-8*sin(PI/6), border/2, boardWidth/8+border, border/2-8*cos(PI/6),
  boardWidth/8+border+8*sin(PI/6), border/2, boardWidth/8+border, border/2+8*cos(PI/6));
  
  quad(boardWidth/4+border-8*sin(PI/6), border/2, boardWidth/4+border, border/2-8*cos(PI/6),
  boardWidth/4+border+8*sin(PI/6), border/2, boardWidth/4+border, border/2+8*cos(PI/6));
  
  quad(boardWidth/4+border-8*sin(PI/6), border/2, boardWidth/4+border, border/2-8*cos(PI/6),
  boardWidth/4+border+8*sin(PI/6), border/2, boardWidth/4+border, border/2+8*cos(PI/6));
  
  quad(boardWidth*3/8+border-8*sin(PI/6), border/2, boardWidth*3/8+border, border/2-8*cos(PI/6),
  boardWidth*3/8+border+8*sin(PI/6), border/2, boardWidth*3/8+border, border/2+8*cos(PI/6));
  
  quad(boardWidth*5/8+border-8*sin(PI/6), border/2, boardWidth*5/8+border, border/2-8*cos(PI/6),
  boardWidth*5/8+border+8*sin(PI/6), border/2, boardWidth*5/8+border, border/2+8*cos(PI/6));
  
  quad(boardWidth*3/4+border-8*sin(PI/6), border/2, boardWidth*3/4+border, border/2-8*cos(PI/6),
  boardWidth*3/4+border+8*sin(PI/6), border/2, boardWidth*3/4+border, border/2+8*cos(PI/6));
  
  quad(boardWidth*7/8+border-8*sin(PI/6), border/2, boardWidth*7/8+border, border/2-8*cos(PI/6),
  boardWidth*7/8+border+8*sin(PI/6), border/2, boardWidth*7/8+border, border/2+8*cos(PI/6));
  
  //bottom dots
  quad(boardWidth/8+border-8*sin(PI/6), boardHeight+border*3/2, boardWidth/8+border, boardHeight+border*3/2-8*cos(PI/6),
  boardWidth/8+border+8*sin(PI/6), boardHeight+border*3/2, boardWidth/8+border, boardHeight+border*3/2+8*cos(PI/6));
  
  quad(boardWidth/4+border-8*sin(PI/6), boardHeight+border*3/2, boardWidth/4+border, boardHeight+border*3/2-8*cos(PI/6),
  boardWidth/4+border+8*sin(PI/6), boardHeight+border*3/2, boardWidth/4+border, boardHeight+border*3/2+8*cos(PI/6));
  
  quad(boardWidth/4+border-8*sin(PI/6), boardHeight+border*3/2, boardWidth/4+border, boardHeight+border*3/2-8*cos(PI/6),
  boardWidth/4+border+8*sin(PI/6), boardHeight+border*3/2, boardWidth/4+border, boardHeight+border*3/2+8*cos(PI/6));
  
  quad(boardWidth*3/8+border-8*sin(PI/6), boardHeight+border*3/2, boardWidth*3/8+border, boardHeight+border*3/2-8*cos(PI/6),
  boardWidth*3/8+border+8*sin(PI/6), boardHeight+border*3/2, boardWidth*3/8+border, boardHeight+border*3/2+8*cos(PI/6));
  
  quad(boardWidth*5/8+border-8*sin(PI/6), boardHeight+border*3/2, boardWidth*5/8+border, boardHeight+border*3/2-8*cos(PI/6),
  boardWidth*5/8+border+8*sin(PI/6), boardHeight+border*3/2, boardWidth*5/8+border, boardHeight+border*3/2+8*cos(PI/6));
  
  quad(boardWidth*3/4+border-8*sin(PI/6), boardHeight+border*3/2, boardWidth*3/4+border, boardHeight+border*3/2-8*cos(PI/6),
  boardWidth*3/4+border+8*sin(PI/6), boardHeight+border*3/2, boardWidth*3/4+border, boardHeight+border*3/2+8*cos(PI/6));
  
  quad(boardWidth*7/8+border-8*sin(PI/6), boardHeight+border*3/2, boardWidth*7/8+border, boardHeight+border*3/2-8*cos(PI/6),
  boardWidth*7/8+border+8*sin(PI/6), boardHeight+border*3/2, boardWidth*7/8+border, boardHeight+border*3/2+8*cos(PI/6));
  
  //left dots
  quad(border/2-8*cos(PI/6), border+boardHeight/4, border/2, border+boardHeight/4-8*sin(PI/6),
  border/2+8*cos(PI/6), border+boardHeight/4, border/2, border+boardHeight/4+8*sin(PI/6));
  
  
  quad(border/2-8*cos(PI/6), border+boardHeight/2, border/2, border+boardHeight/2-8*sin(PI/6),
  border/2+8*cos(PI/6), border+boardHeight/2, border/2, border+boardHeight/2+8*sin(PI/6));
  
  quad(border/2-8*cos(PI/6), border+boardHeight*3/4, border/2, border+boardHeight*3/4-8*sin(PI/6),
  border/2+8*cos(PI/6), border+boardHeight*3/4, border/2, border+boardHeight*3/4+8*sin(PI/6));
  
  //right dots
  quad(boardWidth+border*3/2-8*cos(PI/6), border+boardHeight/4, boardWidth+border*3/2, border+boardHeight/4-8*sin(PI/6),
  boardWidth+border*3/2+8*cos(PI/6), border+boardHeight/4, boardWidth+border*3/2, border+boardHeight/4+8*sin(PI/6));
  
  
  quad(boardWidth+border*3/2-8*cos(PI/6), border+boardHeight/2, boardWidth+border*3/2, border+boardHeight/2-8*sin(PI/6),
  boardWidth+border*3/2+8*cos(PI/6), border+boardHeight/2, boardWidth+border*3/2, border+boardHeight/2+8*sin(PI/6));
  
  quad(boardWidth+border*3/2-8*cos(PI/6), border+boardHeight*3/4, boardWidth+border*3/2, border+boardHeight*3/4-8*sin(PI/6),
  boardWidth+border*3/2+8*cos(PI/6), border+boardHeight*3/4, boardWidth+border*3/2, border+boardHeight*3/4+s(PI/6));
  
  fill(0);
  stroke(0);
  
  //Upper left hole
  translate(border+6,border+4);
  rotate(-PI/6);
  ellipse(0, 0, 60, 70);
  rotate(PI/6);
  translate(-border-6,-border-4);
  
  //Upper right hole
  translate(boardWidth+border-5,border+4);
  rotate(PI/6);
  ellipse(0, 0, 60, 70);
  rotate(-PI/6);
  translate(-boardWidth-border+5,-border-4);
  
  //Bottom left hole
  translate(border+6,boardHeight+border-2);
  rotate(PI*7/6);
  ellipse(0, 0, 60, 70);
  rotate(-PI*7/6);
  translate(-border-6,-boardHeight-border+2);
  
  //Bottom right hole
  translate(boardWidth+border-2,boardHeight+border-4);
  rotate(PI*10/6);
  ellipse(0, 0, 60, 70);
  rotate(-PI*10/6);
  translate(-boardWidth-border+2,-boardHeight-border+4);
  
    //Upper middle hole
  ellipse(boardWidth/2+border,border-5, 55, 60);
  
  //Bottom middle hole
  ellipse(boardWidth/2+border,boardHeight+border+5, 55, 60);
  
  fill(41, 163, 33);
  rect(border, border, boardWidth, boardHeight);
  noFill();
  
  stroke(255);
  translate(border,border+35);
  line(0,0,35,-35);
  translate(-border,-border-35);
  
  translate(border+boardWidth,border+35);
  line(0,0,-35,-35);
  translate(-border-boardWidth,-border-35);
  
  
  translate(border,border+boardHeight-35);
  line(0,0,35,35);
  translate(-border,-border-boardHeight+35);
  
  
  translate(border+boardWidth-35,border+boardHeight);
  line(0,0,35,-35);
  translate(-border-boardWidth+35,-border-boardHeight);
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

void mouseClicked() {
  if (template!=1) {
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
    drawArrow();
    // draw marker on power bar
    fill(157, 5, 240);
    rect(1120, strength, 60, 8, 4);
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
