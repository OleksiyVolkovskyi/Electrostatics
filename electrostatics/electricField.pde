class electricField{
  PVector location; //float xpos, ypos;
  PVector direction; //float vx, vy;
  int r;
  float q;


  electricField (float ix, float iy, int ir, float iq){
    q = iq;
    location = new PVector(ix,iy);
    direction = new PVector(0,0);
    r = ir;
  }
  void update(){
    noStroke();
    if(direction.mag()!=0){
      direction = PVector.mult(direction  ,  (sigmoid(direction.mag()*50)/direction.mag())  );
      //direction.x *=sigmoid(direction.mag()*50)/direction.mag();
      //direction.y *=sigmoid(direction.mag()*50)/direction.mag();
      drawArrow(location.x, location.y, location.x+direction.x*40, location.y+direction.y*40, 5, sigmoid(direction.mag()*50));
    }
    direction.x = 0;
    direction.y = 0;
  }

  void force(sourceCharge c){
    float d = max(pow(pow(location.x-c.location.x,2)+pow(location.y-c.location.y,2),0.5),10);
    direction.x += q*c.q*(location.x-c.location.x)/pow(d,3);
    direction.y += q*c.q*(location.y-c.location.y)/pow(d,3);
  }
  
  void force(testCharge t){
    float d = max(pow(pow(location.x-t.location.x,2)+pow(location.y-t.location.y,2),0.5),1);
    direction.add(new PVector(q*t.q*(location.x-t.location.x)/pow(d,3),q*t.q*(location.y-t.location.y)/pow(d,3)));
  }

}


float sigmoid(float x){
  return 2*(1.0/(1+pow(1.1,-x)))-1;
}
