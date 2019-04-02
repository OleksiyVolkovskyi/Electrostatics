ArrayList<testCharge> testCharges = new ArrayList<testCharge>();
ArrayList<sourceCharge> sourceCharges = new ArrayList<sourceCharge>();
ArrayList<electricField> electricFields = new ArrayList<electricField>();
boolean placing = false;
boolean paused = false;
String stage;
PVector oldPos;
boolean init = true;

ArrayList<Button> buttons = new ArrayList<Button>();

Method circle = new Circle();
Method streaks = new Streaks(sourceCharges);

void drawIntro(){
  if (init){
    background(0);
    fill(255,255,255);
    textAlign(CENTER, CENTER);
    textSize(80);
    text("Electrostatics Hockey", 160, 70, 680, 300);
    buttons = new ArrayList<Button>();
    buttons.add(new Button(new float[] {350,400,650,490}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Start Game", 32, circle));
    buttons.add(new Button(new float[] {350,500,650,590}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Level Select", 32, circle));
    buttons.add(new Button(new float[] {350,600,650,690}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Instructions", 32, circle));
    init = false;
  }
  for (Button b: buttons){
      b.update();
  }
}

void drawLvlSelect(){
 
}

void drawMainGame(){
  if (paused){
    return;  
  }
  background(0);
  if (placing){
    drawArrow(oldPos.x, oldPos.y, mouseX, mouseY, 10, 1);
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
  for (Button b: buttons){
      b.update();
  }
}

void drawInstruction(){
 
}

void setup() {  // this is run once.   
    // set the background color
    background(0);
    // canvas size (Integers only, please.)
    size(1000,900); 
    // smooth edges
    smooth();
    // limit the number of frames per second
    frameRate(60);
    // set the width of the line. 
    strokeWeight(3);
    for (int i = 50; i<1000; i += 50){
        for (int j = 50; j< 1000; j+=50){
            electricFields.add(new electricField(i,j,15,-50));
        }
    }
    PFont font = createFont("zorque.ttf", 128, true);
    textFont(font);
    
    stage = "intro";
    
    //buttons.add(new Button(new float[] {50,30,150,100}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Start", 24, circle));
    //buttons.add(new Button(new float[] {400,450,500,500}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Streaks", 24, streaks));
} 

void draw() {  // this is run repeatedly.
  if (stage.equals("intro")){
    drawIntro();
  }
  else if (stage.equals("lvlselect")){
    drawLvlSelect();
  }
  else if (stage.equals("main")){
    drawMainGame();
  }
  else if (stage.equals("instruction")){
    drawInstruction();
  }
  
}


void keyPressed(){
  if (stage.equals("intro")){
    if (key == ' '){
        placing = !placing;
        if (placing){
          oldPos = new PVector(mouseX,mouseY);
        }
        else{
          testCharges.add(new testCharge(mouseX, mouseY,15,5, new PVector(  -0.01*(oldPos.x-mouseX), -0.01*(oldPos.y-mouseY)  )));
        }
        
          
    }
    if (key == 's'){
        sourceCharges.add(new sourceCharge(mouseX, mouseY,15,-50));
    }
  }
    if (key == 'p'){
        paused = !paused;
    }
}
void mouseReleased(){
  for (Button b: buttons){
    b.clicked();
  }
}
