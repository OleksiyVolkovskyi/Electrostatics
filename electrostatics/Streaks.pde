public class Streaks implements Method{
  ArrayList<sourceCharge> sourceCharges;
  public Streaks(ArrayList<sourceCharge> s){
    sourceCharges = s;
  }
  public void activate(){
     sourceCharges.add(new sourceCharge(350, 300,15,-50));
     sourceCharges.add(new sourceCharge(550, 300,15,-50));
     sourceCharges.add(new sourceCharge(240,494,15,-50));
     sourceCharges.add(new sourceCharge(308,541,15,-50));
     sourceCharges.add(new sourceCharge(374,585,15,-50));
     sourceCharges.add(new sourceCharge(456,596,15,-50));
     sourceCharges.add(new sourceCharge(529,578,15,-50));
     sourceCharges.add(new sourceCharge(607,539,15,-50));
     sourceCharges.add(new sourceCharge(669,500,15,-50));
  }
}
