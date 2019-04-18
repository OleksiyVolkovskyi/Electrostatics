public class LvlSelect implements Method{
  String[] settings;
  int level;
  public LvlSelect(String[] s, int l){
    settings = s;
    level = l;
  }
  public void activate(){
    settings[0] = "main";
    settings[1] = "true";
    settings[2] = Integer.toString(level);
  }
}
