ArrayList<Ball> balls;
ArrayList<Ball> stripedSunk;
ArrayList<Ball> solidsSunk;
int solidsSunkInTurn;
int stripedSunkInTurn;
CueBall cue;
Ball eightBall;
boolean stripedTurn;
boolean solidsTurn;
int solidBalls;
int stripedBalls;
boolean placeCue;
final int r = 16;

// for drawing the table (dimensions)
int boardWidth;
int boardHeight;
int border;
int sideBar;
int scoreBar;

// for user interaction
boolean canShoot;
float strength;
PVector aimDirection; // should be kept normalized
Controller keyboardInput;


void setup() {
  size(1200, 700);
  background(0);
  boardWidth = 1000;
  boardHeight = 500;
  border = 50;
  sideBar = 100;
  scoreBar = 100;

  balls = new ArrayList<Ball>();
  int x = width-sideBar-border-boardWidth/4;
  int y = (height-100)/2;
  balls.add(new Ball(x-r/2-7, y+6, true, color(255, 240, 0), 9));
  balls.add(new Ball(x+r*sin(PI/6)-r/2-2, y+r/2+sin(PI/3)*r-r/2, false, color(138, 6, 6), 7));
  balls.add(new Ball(x+r*sin(PI/6)-r/2+4, y-r/2-sin(PI/3)*r+r/2-2, true, color(133, 34, 239), 12));
  eightBall = new Ball(x+2*r*sin(PI/6)+r+1, y+1, false, color(0), 8);
  balls.add(eightBall);
  balls.add(new Ball(x+2*r*sin(PI/6)+r, y+r/2+sin(PI/3)*2*r+1, true, color(138, 6, 6), 15));
  balls.add(new Ball(x+2*r*sin(PI/6)+r, y-r/2-sin(PI/3)*2*r+2, false, color(255, 240, 0), 1));
  balls.add(new Ball(x+3*r*sin(PI/6)+2*r+5, y+r/2+sin(PI/3)*r-r/2+6, true, color(0, 48, 255), 10));
  balls.add(new Ball(x+3*r*sin(PI/6)+2*r+5, y-r/2-sin(PI/3)*r+r/2-2, false, color(232, 28, 28), 3));
  balls.add(new Ball(x+3*r*sin(PI/6)+2*r+4, y+r/2+sin(PI/3)*3*r+5, false, color(17, 159, 19), 6));
  balls.add(new Ball(x+3*r*sin(PI/6)+2*r+5, y-r/2-sin(PI/3)*3*r-1, true, color(17, 159, 19), 14));
  balls.add(new Ball(x+4*r*sin(PI/6)+3*r+9, y+1, true, color(245, 121, 14), 13));
  balls.add(new Ball(x+4*r*sin(PI/6)+3*r+9, y+r/2+sin(PI/3)*2*r+1, false, color(0, 48, 255), 2));
  balls.add(new Ball(x+4*r*sin(PI/6)+3*r+9, y-r/2-sin(PI/3)*2*r+2, false, color(133, 34, 239), 4));
  balls.add(new Ball(x+4*r*sin(PI/6)+3*r+9, y+r/2+sin(PI/3)*4*r+1, true, color(232, 28, 28), 11));
  balls.add(new Ball(x+4*r*sin(PI/6)+3*r+9, y-r/2-sin(PI/3)*4*r+1, false, color(245, 121, 14), 5));
  cue = new CueBall(border+boardWidth/4, y);
  balls.add(cue);

  //other
  textAlign(CENTER);

  canShoot = false;
  solidsTurn = true;
  stripedTurn = false;
  placeCue = false;
  solidsSunkInTurn = -1;
  stripedSunkInTurn = -1;
  solidsSunk = new ArrayList<Ball>();
  stripedSunk = new ArrayList<Ball>();

  aimDirection = new PVector(0, 1).normalize();

  strength = 500;

  keyboardInput = new Controller();

  // draw table
  drawTable();
  // draw power bar
  powerBar();
  // draw score bar
  scoreBar();
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

boolean mouseOnTable() {
  return mouseX > border && mouseX < boardWidth + border && mouseY > border && mouseY < boardHeight + border;
}

void mouseClicked(){
  if (placeCue && mouseOnTable()){
    cue.reset(mouseX, mouseY);
    placeCue = false;
    canShoot = true;
  }
}

void keyPressed() {
  keyboardInput.press(keyCode);
}

void keyReleased() {
  keyboardInput.release(keyCode);
}

void draw() {
  background(0);
  scoreBar();
  powerBar();
  drawTable();
  int stopped = 0;
  
  if (canShoot && (!cue.isOnBoard() || keyboardInput.isPressed(Controller.zero)) ) {
      placeCue = true;   
      canShoot = false;
      cueBallText();
   }

  if (canShoot) {
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
      solidsSunkInTurn = 0;
      stripedSunkInTurn = 0;
    }
  }


  for (int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);

    if (ball.isOnBoard()) {
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
      if ( !ball.isOnBoard() && ball != cue) {
        if (ball.isStriped) {
          stripedSunk.add(ball);
          stripedSunkInTurn++;
        } else {
          solidsSunk.add(ball);
          solidsSunkInTurn++;
        }
      }

      ball.move();
      ball.getShape();
    } else {
      stopped++;
    }
  }

  if (stopped == balls.size()) {
    canShoot = true;
    if (solidsTurn && solidsSunkInTurn == 0) {
      solidsTurn = false;
      stripedTurn = true;
    } else if (stripedTurn && stripedSunkInTurn == 0) {
      solidsTurn = true;
      stripedTurn = false;
    }
    solidsSunkInTurn = -1;
    stripedSunkInTurn = -1;
  }
}


// ---------- Graphics ----------
void drawTable() {
  stroke(0);

  fill(122, 72, 38);
  rect(0, 0, boardWidth+2*border, boardHeight+2*border);

  fill(41, 163, 33);
  rect(border, border, boardWidth, boardHeight);

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
    boardWidth+border*3/2+8*cos(PI/6), border+boardHeight*3/4, boardWidth+border*3/2, border+boardHeight*3/4+8*(PI/6));

  fill(0);
  stroke(0);

  // middle holes
  arc(550, 50, 56, 60, PI, 2*PI, OPEN);
  arc(550, 550, 56, 60, 0, PI, OPEN);

  // top left corner
  translate(67.5, 67.5);
  rotate(-PI/4);
  arc(0, 0, 50, 80, PI, 2*PI, OPEN);
  rotate(PI/4);
  translate(-67.5, -67.5);

  // bottom left corner
  translate(67.5, 532.5);
  rotate(PI/4);
  arc(0, 0, 50, 80, 0, PI, OPEN);
  rotate(PI/-4);
  translate(-67.5, -532.5);

  // top right corner
  translate(1032.5, 67.5);
  rotate(PI/4);
  arc(0, 0, 50, 80, PI, 2*PI, OPEN);
  rotate(-PI/4);
  translate(-1032.5, -67.5);

  // bottom right hole
  translate(1032.5, 532.5);
  rotate(-PI/4);
  arc(0, 0, 50, 80, 0, PI, OPEN);
  rotate(PI/4);
  translate(-1032.5, -532.5);
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

void scoreBar() {
  textSize(24);
  //player #
  if (solidsTurn) {
    fill(255, 0, 0);
    text("Player 1 (solids)", border+boardWidth/2-50, border*2+boardHeight+31);
  } else {
    fill(0, 0, 255);
    text("Player 2 (striped)", border+boardWidth/2-55, border*2+boardHeight+81);
  }
  int solids = 50;
  int stripes = 50;
  for (int i = 0; i < balls.size(); i++) {
    if(balls.get(i).getNum() != -1 && balls.get(i).getNum() != 8){
      if(!balls.get(i).isStriped()){
        balls.get(i).getShape(border+boardWidth/2+solids, border*2+boardHeight+25);
        solids+=50;
      }else{
        balls.get(i).getShape(border+boardWidth/2+stripes, border*2+boardHeight+75);
        stripes+=50;
      }
    }
  }
  fill(255);
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

void winScreen(int player) {
  fill(60, 255, 0);
  rect(0, height-scoreBar, width, scoreBar);
  fill(0);
  textSize(40);
  text("Player " + player + " wins!", width/2, height - scoreBar/2);
}

int getPlayer(){
  if (solidsTurn){
    return 1;
  }else{
    return 2;
  }
}

void cueBallText(){
  fill(0);
  rect(0, height-100, width, 100);
  fill(255);
  text("Player " + getPlayer() + ": click to place cue ball", border+boardWidth/2, border*2+boardHeight+57);
}
