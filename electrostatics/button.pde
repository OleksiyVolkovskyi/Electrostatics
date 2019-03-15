class Button{
    float[] pos = new float[4];
    int[] activeColor = new int[4];
    int[] passiveColor = new int[4];
    
    Button(float[] p, int[] ac, int[] pc){
      pos = p;
      activeColor = ac;
      passiveColor = pc;
    }
    
    public boolean inBound(){
      if (mouseX>=pos[0]&&mouseX<=pos[2]&&mouseY>=pos[1]&&mouseY<=pos[3]){
        return true;
      }
      return false;
    }
    
    private void drawButton(){
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
    }
    
    
    void update(){
      drawButton();
    }
}
