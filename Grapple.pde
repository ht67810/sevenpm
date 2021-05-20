//Class for the grappling points
public class Grapple {
  //Position
 PVector position = new PVector(0, 0);
 
 //Aesthetic constants
 
 //Outer Circle
 public static final int outerDiameter = 10;
 
 //Colour
 public static final int or = 0;
 public static final int og = 0;
 public static final int ob = 0;
 
 //Inner Circle - Creates hoop look
 public static final int innerDiameter = 8;
 
 //Colour
 public static final int ir = backgroundColour;
 public static final int ig = backgroundColour;
 public static final int ib = backgroundColour;
 
 //For raycasting
 public float rayDistance = 0.5;
 
 public Grapple(int x, int y) {
   this.position.set(x, y);
  }
  
 public void draw() {
  fill(or, og, ob);
  ellipse(position.x, position.y, outerDiameter, outerDiameter);
  fill(ir, ig, ib);
  ellipse(position.x, position.y, innerDiameter, innerDiameter);
 }
 
 //Tests to see if the player is in line of sight with the grapple
 //Its in this file so that there is less clutter than in the player file
 //Code taken from my submission for practical 2
 public boolean checkLineOfSight(Player player) {
   PVector rayPosition = position.copy();
   PVector rayHeading = position.copy().sub(player.position).normalize().mult(-rayDistance);
   boolean hasRayCollided = false;
   while(!hasRayCollided) {
     rayPosition.add(rayHeading);
    if (rayPosition.x <= 0 || rayPosition.x >= windowWidth || rayPosition.y <= 0 || rayPosition.y >= windowHeight) {
     return false; 
    }
    
    for (Ground g: groundPieces) {
     if (rayPosition.x > g.position.x && rayPosition.x < g.position.x + g.rectWidth && rayPosition.y > g.position.y && rayPosition.y < g.position.y + g.rectHeight) {
      hasRayCollided = true; 
     }
    }
    if (abs(rayPosition.x - player.position.x) < player.radius && abs(rayPosition.y- player.position.y) < player.radius) {
     return true; 
    }
   }
    return false;
 }
}
