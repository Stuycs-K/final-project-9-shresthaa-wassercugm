ArrayList<Ball> balls;
final int r = 16;
final double m = 0.16; //kilograms
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
  Ball toAdd = new Ball(x, y, stripe, balls.size());
  
  if (canPlace(toAdd)){
    balls.add(toAdd);
  }
}

void draw() {
  drawTable();
  rect(border, border, boardWidth, boardHeight);
  for (Ball ball : balls) {
    ball.move();
    ball.getShape();
  }
}
