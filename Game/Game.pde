ArrayList<Ball> balls;
CueBall cue;
final int r = 16;
int boardWidth;
int boardHeight;
int border;
boolean canShoot;
PVector aimDirection;

void drawTable(){
  stroke(0);
  fill(122,72,38);
  rect(0,0, width, height);
  fill(41,163,33);
  rect(border, border, boardWidth, boardHeight);
}

void setup() {
  size(1100, 600);
  boardWidth = 1000;
  boardHeight = 500;
  border = 50;

  balls = new ArrayList<Ball>();
  cue = new CueBall(550, 300);
  balls.add(cue);
  
  //other
  textAlign(CENTER);
  canShoot = false;
  aimDirection = new PVector(0,1).normalize();
  
  // draw table
  drawTable();
  
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

void draw() {
  drawTable();
  int stopped = 0;
  
  if (canShoot){
   strokeWeight(4);
   stroke(112,38,209);
   float x = cue.getP().x;
   float y = cue.getP().y;
   line(x, y, x + aimDirection.x*100, y + aimDirection.y*100);
   strokeWeight(1);
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
