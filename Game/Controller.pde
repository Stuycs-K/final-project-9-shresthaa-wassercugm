class Controller {
  PVector s;
  double d;
  boolean[] inputs;
  int code = 0;

  public Controller() {
    inputs = new boolean[2];//2 valid buttons: direction, strength of hit
  }
  
  void initialD(CueBall x){
    x.setD(x.getP().sub(new PVector(mouseX,mouseY)).normalize());
  }
  
  void initialS(CueBall x){
    x.setS(count);
  }
  
  boolean isPressed(int command) {
    return inputs[command];
  }

  void press(CueBall x) {
    if(code == 0){
      inputs[0] = true;
    }
    if(code == 1){
      inputs[1] = true;
    }
    if(code == 2){
      if(aimBall){
        x.aim();
        code = 0;
      }else{
        System.out.print("wait until simulation movement ends");
      }
    }
  }
  
  void release(CueBall x) {
    if(code == 0){
      inputs[0] = false;
      initialD(x);
      code++;
    }else if(code == 1){
      inputs[1] = false;
      initialS(x);
      code = 2;
    }
  }
}
