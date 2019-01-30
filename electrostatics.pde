ArrayList<testCharge> testCharges = new ArrayList<testCharge>();
ArrayList<sourceCharge> sourceCharges = new ArrayList<sourceCharge>();
ArrayList<electricField> electricFields = new ArrayList<electricField>();
boolean placing = false;

class testCharge{
  PVector location; //float xpos, ypos;
  PVector velocity; //float vx, vy;
  int r;
  float q;

  testCharge (float ix, float iy, int ir, float iq, PVector iv){
    q = iq;
    location = new PVector(ix,iy);
    velocity = iv;
    r = ir;
  }
  void update(){
    location.add(velocity);
    noStroke();
    fill(0,0,200);
    ellipse(location.x, location.y , r, r);
    drawArrow(location.x, location.y, location.x+velocity.x*30, location.y+velocity.y*30, 5);
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
    drawArrow(location.x, location.y, location.x+direction.x*30, location.y+direction.y*30, 5);
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

void drawArrow(float cx, float cy, float fx, float fy, int size){
  float len = (float) Math.sqrt((fx-cx)*(fx-cx)+(fy-cy)*(fy-cy));
  float angle = -atan2(cx-fx,cy-fy)-PI/2;
  pushMatrix();
  translate(cx, cy);
  rotate(angle);
  stroke(255);
  line(0,0,len, 0);
  line(len, 0, len - size, -size);
  line(len, 0, len - size, size);
  popMatrix();
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
    
    electricFields.add(new electricField(320,350,15,-5));
    
    //sourceCharges.add(new sourceCharge(320,350,15,-5));
} 
//testCharge (float ix, float iy, int ir, float iq)
//sourceCharge (float ix,float iy,float ir,float iq)

void draw() {  // this is run repeatedly.  
  background(0);
  
  if (placing){
    drawArrow(oldPos.x, oldPos.y, mouseX, mouseY, 10);
  }
  
  //Test charges with each other
  for (int i = 0; i<testCharges.size(); i++){
    for (int j = 0; j<testCharges.size(); j++){
      if (i!=j)
        testCharges.get(i).force(testCharges.get(j));
    }
  }
  
  //Test with source
  for (int i = 0; i<testCharges.size(); i++){
    for (sourceCharge q : sourceCharges)
         testCharges.get(i).force(q);
  }
  
  //Electric Field with Test
  for (testCharge t : testCharges){
    for (electricField e : electricFields)
         e.force(t);
  }
        
  //Electric Field with Source
  for (sourceCharge c : sourceCharges){
    for (electricField e : electricFields)
         e.force(c);
  }
  
  //Update Everything
  for (electricField e : electricFields)
        e.update();
  for (sourceCharge q : sourceCharges)
        q.update();
  for (testCharge t : testCharges)
        t.update();
}

PVector oldPos;
void keyPressed(){
    if (key == ' '){
        placing = !placing;
        if (placing){
          oldPos = new PVector(mouseX,mouseY);
        }
        else{
          testCharges.add(new testCharge(mouseX, mouseY,15,5, oldPos.sub(new PVector(mouseX, mouseY)).mult(-0.01)));
        }
        
          
    }
    if (key == 's'){
        sourceCharges.add(new sourceCharge(mouseX, mouseY,15,-5));
    }
}
