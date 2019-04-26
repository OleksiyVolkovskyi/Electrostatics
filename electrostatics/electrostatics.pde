/*
To Do List:
create placing stage and test stage
    placing - only placing test charges
    test - no controls
create levels
create instructions
*/

//Global Variables :)
ArrayList<testCharge> testCharges;
ArrayList<sourceCharge> sourceCharges;
ArrayList<electricField> electricFields;
boolean placing = false;
boolean paused = false;
PVector oldPos;
Level level;
int deathCount = 0;
PVector initialPos;
PVector initialDir;
boolean win = false;
boolean loss = false;
boolean showDeathCount = true;
boolean launched;
String[] settings = new String[3];
ArrayList<Button> buttons = new ArrayList<Button>();

Method circle = new Circle();
Method startMainGame = new MainGame(settings);
Method backToIntro = new BackToIntro(settings);
Method lvlSelectScreen = new LvlSelectScreen(settings);

void setup() {  // this is run once at the start  
    // set the background color
    background(0);
    // canvas size (Integers only, please.)
    size(1000,800); 
    // smooth edges
    smooth();
    // limit the number of frames per second
    frameRate(60);
    // set the width of the line. 
    strokeWeight(3);

    PFont font = createFont("zorque.ttf", 128, true);
    textFont(font);
    
    settings[0] = "intro";
    settings[1] = "true";
    
    //buttons.add(new Button(new float[] {50,30,150,100}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Start", 24, circle));
    //buttons.add(new Button(new float[] {400,450,500,500}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Streaks", 24, streaks));
}

void drawIntro(){ //Intro Screen
  if (settings[1].equals("true")){
    background(0);
    fill(255,255,255);
    textAlign(CENTER, CENTER);
    textSize(80);
    text("Electrostatics Hockey", 160, 70, 680, 300);
    buttons = new ArrayList<Button>();
    buttons.add(new Button(new float[] {350,400,650,490}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Start Game", 32, startMainGame));
    buttons.add(new Button(new float[] {350,500,650,590}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Level Select", 32, lvlSelectScreen));
    buttons.add(new Button(new float[] {350,600,650,690}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Instructions", 32, circle));
    settings[1] = "false";
  }
  for (Button b: buttons){
      b.update();
  }
}

void drawLvlSelect(){ // Level Selection Screen
   if (settings[1].equals("true")){
    background(0);
    fill(255,255,255);
    textAlign(CENTER, CENTER);
    textSize(80);
    text("Select Level", 160, 10, 680, 100);
    buttons = new ArrayList<Button>();
    buttons.add(new Button(new float[] {870,695,980,740}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Back", 32, backToIntro));
    
    int index = 1;
    int h = height - 20;
    
    for (int y = h/6; y<h-h/6-1; y+=h/6){
      for (int x = width/8; x<width-width/8; x+=width/8){
        buttons.add(new Button(new float[] {x+5,20+y+5,x+width/8-5,20+y+h/6-5}, new int[] {100,100,100,100},new int[] {200,200,200,200}, Integer.toString(index), 32, 
            new LvlSelect(settings, index)));
        index++;
      }
    }
    settings[1] = "false";
  }
  for (Button b: buttons){
      b.update();
  }
}

void drawMainGame(){ // Main Game Screen
  if (settings[1].equals("true")){
    showDeathCount = true;
    loss = false;
    win = false;
    placing = false;
    testCharges = new ArrayList<testCharge>();
    sourceCharges = new ArrayList<sourceCharge>();
    electricFields = new ArrayList<electricField>();
    for (int i = 50; i<1000; i += 50){
        for (int j = 50; j< 1000; j+=50){
            electricFields.add(new electricField(i,j,15,-50));
        }
    }
    buttons = new ArrayList<Button>();
    buttons.add(new Button(new float[] {870,695,980,740}, new int[] {100,100,100,100},new int[] {200,200,200,200}, "Back", 32, backToIntro));
    settings[1] = "false";
    level = new Level(settings[2]);
    level.load();
    initialPos = new PVector(level.objects.get(level.objects.size()-4), level.objects.get(level.objects.size()-3));
    initialDir = new PVector(level.objects.get(level.objects.size()-2), level.objects.get(level.objects.size()-1));
    testCharges.add(new testCharge(initialPos.x, initialPos.y, 15, 5, initialDir));
  }
  if (paused){
    return;  
  }
  if (win){
    fill(30,200,30);
    textAlign(CENTER, CENTER);
    textSize(90);
    text("Stage Completed", 160, 70, 680, 300);
  }
  else if(loss){
    fill(200,39,30);
    textAlign(CENTER, CENTER);
    textSize(90);
    text("Crashed", 160, 70, 680, 300);
  }
  else{
  background(0);
  level.update();
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
  level.update();
  for (sourceCharge q : sourceCharges)
        q.update();
  for (testCharge t : testCharges){
        if(launched)
            t.move();
        t.update();
  }
  }
  for (Button b: buttons){
      b.update();
  }

  
  //Check Goal
  float x = testCharges.get(0).location.x;
  float y = testCharges.get(0).location.y;
  if (!win&&!loss&&x>=level.objects.get(level.objects.size()-8)
  &&y>=level.objects.get(level.objects.size()-7)
  &&x<=level.objects.get(level.objects.size()-6)
  &&y<=level.objects.get(level.objects.size()-5)){
        buttons.add(new Button(new float[] {350,400,650,490},new int[] {100,100,100,100}, new int[] {200,200,200,200}, "Next Level", 32, 
            new LvlSelect(settings, Integer.valueOf(settings[2])+1)));
        win = true;
  }
  
  //Check Collision
  for(int i = 0; !win&&!loss&&i<level.numObstacles; i++){
    if (x>=level.objects.get(4*i)&&y>=level.objects.get(4*i+1)&&x<=level.objects.get(4*i+2)&&y<=level.objects.get(4*i+3)){
        loss = true;
        deathCount++;
        buttons.add(new Button(new float[] {350,400,650,490},new int[] {100,100,100,100}, new int[] {200,200,200,200}, "Retry", 32, 
            new LvlSelect(settings, Integer.valueOf(settings[2]))));
    }
  }
  
  //Display Death Count
  if(showDeathCount){
    fill(255,255,255);
    textAlign(LEFT, CENTER);
    textSize(25);
    text("Death Count: " + deathCount, 0,-10,250,60);
  }
  if(loss||win)
    showDeathCount = false;
  
  
}

void drawInstruction(){ //Instruction Screen

}


void draw(){  // this is run repeatedly (one frame)
  if (settings[0].equals("intro")){
    drawIntro();
  }
  else if (settings[0].equals("lvlselect")){
    drawLvlSelect();
  }
  else if (settings[0].equals("main")){
    drawMainGame();
  }
  else if (settings[0].equals("instruction")){
    drawInstruction();
  }
  
}

void keyPressed(){ // Event of a Key Press
  if (settings[0].equals("main")){
    if (key == ' '){
       if(win||loss||launched)
           settings[1]="true";
       else
           launched = true;
    }
    if (key == 's' && !launched){
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
