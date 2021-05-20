

public class Spike {
  
  PShape spikeIcon = loadShape("spike.svg");
  PVector position = new PVector(0, 0);
  float rotation = 0;
  final int iconWidth = 25;
  final int iconHeight = 25;
  
  public Spike(int x, int y, int rotation) {
    position.set(x, y);
    this.rotation = rotation;
  }
  
  void draw() {
   shapeMode(CENTER);
   pushMatrix();
   translate(position.x, position.y);
   rotate(rotation * HALF_PI);
   shape(spikeIcon, 0, 0, iconWidth, iconHeight);
   popMatrix();
  }
}
