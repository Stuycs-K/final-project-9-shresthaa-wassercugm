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
PVector aimDirection; // should be kept normalized
Controller keyboardInput;

void drawTable(){
  stroke(0);
  fill(122,72,38);
  rect(0,0, boardWidth+2*border, boardHeight+2*border);
  fill(41,163,33);
  rect(border, border, boardWidth, boardHeight);
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
  
  aimDirection = new PVector(0,1).normalize();
  
  keyboardInput = new Controller();
  
  // draw table
  drawTable();
  // draw side bar
  fill(255);
  textSize(25);
  text("power", 1150, 50);
  
}

boolean canPlace(Ball aBall){
  for (Ball ball : balls){
    if (aBall.isOverlapping(ball)){
      return false;
    }
  }
  return true;
}

void mouseClicked(){
  int x = mouseX;
  int y = mouseY;
  if (x < border+r){ x = border+r; }
  if (x > width-border-r){ x = width-border-r; } 
  if (y < border+r){ y = border+r; }
  if (y > height-border-r){ y = height-border-r; }
  
  boolean stripe = true;
  if (Math.random() < 0.5){stripe=false;}
  Ball toAdd = new Ball(x, y, stripe, balls.size());
  
  if (canPlace(toAdd)){
    balls.add(toAdd);
  }
}

void mouseDragged(){
  if (canShoot){
   aimDirection = new PVector(mouseX - cue.getP().x, mouseY - cue.getP().y);
   aimDirection.normalize();
  }
}

void drawArrow(){
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
  drawTable();
  int stopped = 0;
  
  if (canShoot){
    drawArrow();
    if (keyboardInput.isPressed(Controller.enter)){
      cue.setV( aimDirection.mult(10) );
      canShoot = false;
    }
  }
  
  
  for (int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    
    // apply collisions
    for (int j = i+1; j < balls.size(); j++){
      Ball other = balls.get(j);
      if (ball.isOverlapping(other)){
        ball.collide(other);
      }
    }
    
    // If the ball is moving, apply friction
    if ( ball.getV().mag() < 0.05 ){
      ball.setV(0,0);
      stopped++;
    }else{
      ball.applyFriction(ball.getForce());
    }
    
    ball.move();
    ball.getShape();
  }
  
  if (stopped == balls.size()){
    canShoot = true;
  }
  
  
}
