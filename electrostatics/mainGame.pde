public class MainGame implements Method{
  String[] settings;
  public MainGame(String[] s){
    settings = s;
  }
  public void activate(){
    settings[0] = "main";
    settings[1] = "true";
    settings[2] = "1";
    settings[3] = "true";
  }
}
