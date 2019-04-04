public class BackToIntro implements Method{
  String[] settings;
  public BackToIntro(String[] s){
    settings = s;
  }
  public void activate(){
    settings[0] = "intro";
    settings[1] = "true";
  }
}
