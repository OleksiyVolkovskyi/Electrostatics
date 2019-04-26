class Button{
    float[] pos = new float[4];
    int[] activeColor = new int[4];
    int[] passiveColor = new int[4];
    String text;
    int size;
    Method function;
    
    Button(float[] p, int[] ac, int[] pc, String t, int s, Method f){
      function = f;
      pos = p;
      activeColor = ac;
      passiveColor = pc;
      text = t;
      size = s;
    }
    
    public boolean inBound(){
      if (mouseX>=pos[0]&&mouseX<=pos[2]&&mouseY>=pos[1]&&mouseY<=pos[3]){
        return true;
      }
      return false;
    }
    
    private void drawButton(){
      rectMode(CORNER);
      if (inBound()){
        stroke(0);
        fill(activeColor[0],activeColor[1],activeColor[2],activeColor[3]);
        rect(pos[0],pos[1],pos[2]-pos[0],pos[3]-pos[1],5);
      }
      else{
        stroke(0);
        fill(passiveColor[0],passiveColor[1],passiveColor[2],passiveColor[3]);
        rect(pos[0],pos[1],pos[2]-pos[0],pos[3]-pos[1],5);
      }
      fill(255,255,255);
      textAlign(CENTER, CENTER);
      textSize(size);
      text(text, pos[0],pos[1],pos[2]-pos[0],pos[3]-pos[1]);
    }
    
    private void clicked(){
      if (inBound()){
        function.activate();
      }
    }
    
    
    void update(){
      drawButton();
      
      
    }
}
