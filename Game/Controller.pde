class Controller{
  static final int enter = 0;
  boolean[] inputs;
  
  public Controller(){
    inputs = new boolean[1];
  }
  
  boolean isPressed(int code){
    return inputs[code];
  }
  
  void press(int code){
    if (code == ENTER){
      inputs[enter] = true;
    }
  }
  
  void release(int code){
    if (code == ENTER){
      inputs[enter] = false;
    }
  }
}
