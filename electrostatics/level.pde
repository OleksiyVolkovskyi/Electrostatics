public class Level{
  String name;
  ArrayList<Integer> obstacles;
  
  public Level(String n){
    name = n;
    obstacles = new ArrayList<Integer>();
  }
  public void load(){
    BufferedReader input = createReader(name+".txt"); 
    int numObstacles = Integer.valueOf(input.readLine());
    for (int i = 0; i<numObstacles; i++){
      String line = input.readLine();
      int x1, y1, x2, y2;
      obstacles.add(Integer.valueOf(line.split(" ")[0]));
      obstacles.add(Integer.valueOf(line.split(" ")[1]));
      obstacles.add(Integer.valueOf(line.split(" ")[2]));
      obstacles.add(Integer.valueOf(line.split(" ")[3]));
    }
    
  }
  public void update(float x, float y){
  
  }
  
}
