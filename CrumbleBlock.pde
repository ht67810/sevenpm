public class CrumbleBlock extends Ground {
  
  final int red = 229;
  final int green = 60;
  final int blue = 60;
  
  public CrumbleBlock(int x, int y, int w, int h) {
   super(x, y, w, h); 
  }
  
  public void draw() {
    fill(red, green, blue);
    rect(position.x, position.y, rectWidth, rectHeight);
  }
}
