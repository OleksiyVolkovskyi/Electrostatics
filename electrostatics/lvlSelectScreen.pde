public class LvlSelectScreen implements Method{
  String[] settings;
  public LvlSelectScreen(String[] s){
    settings = s;
  }
  public void activate(){
    settings[0] = "lvlselect";
    settings[1] = "true";
  }
}
