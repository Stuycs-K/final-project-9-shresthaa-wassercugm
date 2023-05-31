public class CueBall extends Ball {

  public CueBall(float x, float y) { //constructor
    super(x, y, false, -1);
  }
  
  void getShape(){
    if (isOnBoard()){
      fill(255);
      stroke(0);
      circle(getP().x, getP().y, (float)r*2);
    }
  }
  
  void reset(){
    setP(boardWidth/2 + border, boardHeight/2 + border);
    setOnBoard(true);
  }
  
}
