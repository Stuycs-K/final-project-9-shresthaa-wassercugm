ArrayList<Ball> balls;
final int r = 16;
int boardWidth;
int boardHeight;
int border;

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
  
  //other
  textAlign(CENTER);
  
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
  Ball toAdd = new Ball(x, y, stripe, balls.size()+1);
  
  if (canPlace(toAdd)){
    balls.add(toAdd);
  }
}

void draw() {
  drawTable();
  for (int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    
    for (int j = i+1; j < balls.size(); j++){
      Ball other = balls.get(j);
      if (ball.isOverlapping(other)){
        ball.collide(other);
      }
    }
    
    if ( abs( ball.getV().x ) < 0.01 && abs( ball.getV().y ) < 0.01 ){
      ball.setVel(0,0);
    }else{
      ball.applyFriction(ball.getForce());
    }
    
    ball.move();
    ball.getShape();
  }
}
