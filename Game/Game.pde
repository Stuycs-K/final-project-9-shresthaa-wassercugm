ArrayList<Ball> balls;

void setup(){
  size(1100, 600);
  balls = new ArrayList<Ball>();
  
  // draw table
  fill(122,72,38);
  rect(0,0,1500,800);
  fill(41,163,33);
  rect(50,50,1000,500);
  
}

void mouseClicked(){
  balls.add( new Ball(mouseX, mouseY) );
}

void draw(){
  fill(41,163,33);
  rect(50,50,1000,500);
  for (Ball ball : balls){
    ball.getShape();
  }
}
