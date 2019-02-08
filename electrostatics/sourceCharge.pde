class sourceCharge{
  float q;
  PVector location; //float xpos, ypos;
  float r;

  sourceCharge (float ix,float iy,float ir,float iq){
    q = iq;
    location = new PVector(ix,iy);
    r = ir;
  }

  void update(){
    fill(200,0,0);
    noStroke();
    ellipse(location.x,location.y,r,r);
  }
}
