class Controller {
  static PVector s;
  static double d;
  boolean[] inputs;

  public Controller() {
    inputs = new boolean[2];//2 valid buttons
  }


  boolean isPressed(int command) {
    return inputs[command];
  }

  void press(int num) {
    if(code == 0){
      inputs[0] = true;
    }
    if(code == 1){
      inputs[1] = true;
    }
  }
  
  void release(int code) {
    if(code == 0){
      inputs[0] = false;
    }
    if(code == 1){
      inputs[1] = false;
    }
  }
}
