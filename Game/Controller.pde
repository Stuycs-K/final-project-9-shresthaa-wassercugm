class Controller {
  PVector s;
  double d;
  boolean[] inputs;
  int code = 0;

  public Controller() {
    inputs = new boolean[2];//2 valid buttons
  }
  
  void initialD(PVector mouse, CueBall x){
    x.setD(x.getP().sub(mouse).normalize());
  }
  
  void initialS(){
    
  }
  
  boolean isPressed(int command) {
    return inputs[command];
  }

  void press() {
    if(code == 0){
      inputs[0] = true;
    }
    if(code == 1){
      inputs[1] = true;
    }
    if(code == 2){
      if(ready){
        code = 0;
      }else{
        System.out.print("wait until simulation ends");
      }
    }
  }
  
  void release(int code) {
    if(code == 0){
      inputs[0] = false;
      code++;
    }
    if(code == 1){
      inputs[1] = false;
      code = 2;
    }
  }
}
