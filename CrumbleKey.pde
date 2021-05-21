//A circular key which can be collected by moving into it
//When all crumble keys have been picked up, all crumble blocks in the level will crumble (disappear)
//Yes this is a Celeste mechanic
public class CrumbleKey {
  final int red = 229;
  final int green = 60;
  final int blue = 60;
  
  final int radius = 10;
  
  final PVector position = new PVector(0, 0);
  
  public CrumbleKey(int x, int y) {
    position.set(x, y);
  }
  
  public void draw() {
    fill(red, green, blue);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}
