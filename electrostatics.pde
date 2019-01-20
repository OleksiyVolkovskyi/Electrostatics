ArrayList<testCharge> testCharges = new ArrayList<testCharge>();
ArrayList<sourceCharge> sourceCharges = new ArrayList<sourceCharge>();

class testCharge{
  PVector location; //float xpos, ypos;
  PVector velocity; //float vx, vy;
  int r;
  float q;

  testCharge (float ix, float iy, int ir, float iq){
    q = iq;
    location = new PVector(ix,iy);
    //velocity = new PVector(pmouseX, pmouseY).sub(new PVector(mouseX, mouseY)).mult(30);
    velocity = new PVector();
    r = ir;
  }
  void update(){
    location.add(velocity);
    fill(0,0,200);
    ellipse(location.x, location.y , r, r);
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
    ellipse(location.x,location.y,r,r);
  }
}


void setup() {  // this is run once.   

    // set the background color
    background(0);

    // canvas size (Integers only, please.)
    size(750,750); 

    // smooth edges
    smooth();

    // limit the number of frames per second
    frameRate(60);

    // set the width of the line. 
    strokeWeight(3);
    
    sourceCharges.add(new sourceCharge(320,350,10,-5));
} 
//testCharge (float ix, float iy, int ir, float iq)
//sourceCharge (float ix,float iy,float ir,float iq)

void draw() {  // this is run repeatedly.  
  background(0);
  for (int i = 0; i<testCharges.size(); i++){
    for (int j = 0; j<testCharges.size(); j++){
      if (i!=j)
        testCharges.get(i).force(testCharges.get(j));
      for (sourceCharge q : sourceCharges)
        testCharges.get(i).force(q);
      testCharges.get(i).update();
    }
  }
  for (sourceCharge q : sourceCharges)
        q.update();
}

void keyPressed(){
    if (key == ' '){
        testCharges.add(new testCharge(mouseX, mouseY,10,5));
    }
    if (key == 's'){
        sourceCharges.add(new sourceCharge(mouseX, mouseY,10,5));
    }
}
