public class Level{
  String name;
  ArrayList<Integer> objects;
  int numObstacles;
  
  public Level(String n){
    name = n;
    objects = new ArrayList<Integer>();
  }
  public void load() throws IOException{
    BufferedReader input = createReader(name+".txt"); 
    numObstacles = Integer.valueOf(input.readLine());
    for (int i = 0; i<numObstacles; i++){
      String line = input.readLine();
      objects.add(Integer.valueOf(line.split(" ")[0]));
      objects.add(Integer.valueOf(line.split(" ")[1]));
      objects.add(Integer.valueOf(line.split(" ")[2]));
      objects.add(Integer.valueOf(line.split(" ")[3]));
      
    }
    String goal = input.readLine();
    objects.add(Integer.valueOf(goal.split(" ")[0]));
    objects.add(Integer.valueOf(goal.split(" ")[1]));
    objects.add(Integer.valueOf(goal.split(" ")[2]));
    objects.add(Integer.valueOf(goal.split(" ")[3]));
    String initalPos = input.readLine();
    objects.add(Integer.valueOf(goal.split(" ")[0]));
    objects.add(Integer.valueOf(goal.split(" ")[1]));
    String initalVector = input.readLine();
    objects.add(Integer.valueOf(goal.split(" ")[0]));
    objects.add(Integer.valueOf(goal.split(" ")[1]));
  }
  public void update(){
    for(int i = 0; i<numObstacles; i++){
      rect(objects.get(4*i),objects.get(4*i+1),objects.get(4*i+2),objects.get(4*i+3));
    }
  }
  
}
