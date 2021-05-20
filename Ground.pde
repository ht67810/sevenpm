//Class for walkable ground spaces
public class Ground {
  //Position and size
  public PVector position = new PVector(0, 0); 
  public int rectWidth;
  public int rectHeight;
 
  //Colour
  public static final int red = 111;
  public static final int green = 111;
  public static final int blue = 111;
  
  public Ground(int x, int y, int w, int h) {
    position.set(x, y);
    this.rectWidth = w;
    this.rectHeight = h;
  }
  
  public void draw() {
    fill(red, green, blue);
    rect(position.x, position.y, rectWidth, rectHeight);
  }
}
