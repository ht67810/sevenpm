public class Weight {
 
  final PVector position = new PVector(0, 0);
  PShape icon = loadShape("weight.svg");
  
  final int iconWidth = 50;
  final int iconHeight = 25;
  
  public Weight(int x, int y) {
   position.set(x, y); 
  }
  
  public void draw() {
    shape(icon, position.x, position.y, iconWidth, iconHeight);
  }
}
