ArrayList<Ball> balls;
final double r = 16;
final double m = 0.16; //kilograms
int boardWidth;
int boardHeight;
int border;

void setup(){
  size(1100, 600);
  boardWidth = 1000;
  boardHeight = 500;
  border = 50;
  
  balls = new ArrayList<Ball>();
  
  // draw table
  fill(122,72,38);
  rect(0,0, width, height);
  fill(41,163,33);
  rect(50,50,boardWidth,boardHeight);
  
}

void mouseClicked(){
  int x = mouseX;
  int y = mouseY;
  balls.add( new Ball(mouseX, mouseY) );
}

void draw(){
  fill(41,163,33);
  rect(50,50,1000,500);
  for (Ball ball : balls){
    ball.getShape();
  }
}
