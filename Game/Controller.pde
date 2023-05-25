class Controller {
  boolean[] inputs;

  public Controller() {
    inputs = new boolean[2];//2 valid buttons: direction, strength of hit
  }
  
  void initialD(){
    cue.setD(cue.getP().sub(new PVector(mouseX,mouseY)).normalize());
  }
  
  void initialS(){
    cue.setF(new PVector(count,count));
  }

  void press() {
    if(aimBall == 0){
      inputs[0] = true;
      initialD();
      aimBall++;
    }else if(aimBall == 1){
      inputs[1] = true;
      initialS();
      aimBall++;
    }else if(aimBall == 2){
      if(ready){
        cue.aim();
        aimBall = 0;
        ready = false;
      }else{
        System.out.print("wait until simulation movement ends");
      }
    }
  }
}
