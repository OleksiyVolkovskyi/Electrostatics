class testCharge{
  PVector location; //float xpos, ypos;
  PVector velocity; //float vx, vy;
  int r;
  float q;

  testCharge (float ix, float iy, int ir, float iq, PVector iv){
    q = iq;
    location = new PVector(ix,iy);
    velocity = iv.copy();
    r = ir;
  }
  void update(){
    noStroke();
    fill(0,0,200);
    ellipse(location.x, location.y , r, r);
    drawArrow(location.x, location.y, location.x+velocity.x*30, location.y+velocity.y*30, 5, 1);
  }
  
  void move(){
    location.add(velocity);
  }

  void force(sourceCharge c){
    float d = max(pow(pow(location.x-c.location.x,2)+pow(location.y-c.location.y,2),0.5),10);
    velocity.x += q*c.q*(location.x-c.location.x)/pow(d,3);
    velocity.y += q*c.q*(location.y-c.location.y)/pow(d,3);
  }
  
  void force(testCharge t){
    float d = max(pow(pow(location.x-t.location.x,2)+pow(location.y-t.location.y,2),0.5),1);
    velocity.add(new PVector(q*t.q*(location.x-t.location.x)/pow(d,3),q*t.q*(location.y-t.location.y)/pow(d,3)));
  }

}
