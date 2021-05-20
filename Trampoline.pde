public class Trampoline {
 public PVector position = new PVector(0, 0);
 
 public final int iconWidth = 50;
 public final int iconHeight = 20;
 
 public Trampoline(int x, int y) {
  position.set(x, y); 
 }
 
 public void draw() {
  ellipseMode(CENTER);
  stroke(230);
  fill(50);
  ellipse(position.x, position.y, iconWidth, iconHeight);
  stroke(0);
 }
}
