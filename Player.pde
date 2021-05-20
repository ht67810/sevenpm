class Player {
  //Movement Vectors
  PVector position = new PVector(100, 50);
  PVector velocity = new PVector(0, 0);
  
  //Movement Constants
  
  //Acceleration due to pressing left and right
  final float moveAcceleration = 0.5;
  
  //Horizontal deceleration when current velocity is above the max speed
  final float walkDeceleration = 0.6;
  
  //Horizontal deceleration when player is not inputting a move command
  final float stopDeceleration = 0.3;
  
  //Horizontal speed above which the character decelerates
  final int maxWalkSpeed = 4;
  
  //Vertical upwards speed that jumping gives you
  final int jumpVelocity = 6;
  
  //Vertical upwards speed that mid-air jumping gives you
  final int boostVelocity = 8;
  
  //Acceleration downwards due to gravity
  final float gravity = 0.2;
  
  //Extent to which gravity increases when moving downwards
  final float downGravityMultiplier = 2;
  
  //Amount extra gravity added when carrying a weight
  final float weightModifier = 0.5;
  
  //Number of frames after walking off an edge the player can jump for
  final int coyoteTimeFrames = 6;
  
  //Movement Variables
  
  //Movement Booleans
  //Is the player holding left
  boolean movingLeft = false;
  //Is the player holding right
  boolean movingRight = false;
  //Is the player holding jump
  boolean holdingJump = false;
  //Is the player in midair, having jumped from the ground or walked off a ledge
  boolean jumping = false;
  //Has the player let go of the jump button since the last time they pressed it
  boolean releasedJump = true;
  //Has the player used their double jump (resets on touching the ground)
  boolean doubleJumpUsed = false;
  //Is the player holding the grapple button
  boolean holdingGrapple;
  //Has the player object checked for a grapple since the last time grapple was pressed
  boolean grappleChecked = false;
  //Has the player picked up a weight
  boolean hasWeight = false;
  
  //Grapple Variables
  //The currently targeted grapple
  Grapple targetGrapple = null;
  
  //Rotation Around the Grapple
  float grappleRotation = 0;
  
  //Length of grapple
  float grappleLength = 0;
  
  //Timers
  int trampolineLockout = 0;
  
  
  //Visual Constants
  final float radius = 12.5;
  final int red = 85;
  final int green = 205;
  final int blue = 252;
  
  
  public Player() {
   
 }
 
 //Movement based on currently held buttons
 void doMovement() {
  if (movingLeft) {
   moveLeft(); 
  }
  
  if (movingRight) {
   moveRight(); 
  }
  
  if (!movingLeft && !movingRight && targetGrapple == null) {
   stopMoving(); 
  }
  
  if (holdingJump) {
   jump(); 
  }
  
  if (holdingGrapple) {
   grapple(); 
  }
 }
 
 //If holding left, accelerate left
 void moveLeft() {
   if (targetGrapple != null) {
     velocity.x -= 0.2*moveAcceleration;
   }
   else {
     velocity.x -= moveAcceleration;
   }
 
 }
 
 //If holding right, accelerate right
 void moveRight() {
   if (targetGrapple != null) {
    velocity.x += 0.2*moveAcceleration; 
   } 
   else {
    velocity.x += moveAcceleration; 
   }
 }
 
 //If the player is not holding left or right, decelerate velocity to 0 over time
 void stopMoving() {
   
   //If velocity is less than deceleration, set it to 0 to prevent overcorrecting
   if (abs(velocity.x) < stopDeceleration) {
     velocity.x = 0;
   }
   
   //Decelerates left when moving right
   else if (velocity.x > 0) {
     velocity.x -= stopDeceleration;
   }
   
   //Decelerates right when moving left
   else if (velocity.x < 0) {
    velocity.x += stopDeceleration; 
   }
 }
 
 //Adds fixed jumping velocity on the first frame jump is pressed if the player is on the ground
 void jump() {
   if (!jumping && releasedJump) {
     //Coyote Time - You can jump for up to coyoteTimeFrames frames after walking off a ledge
     //Or if you are on the ground
     if (velocity.y <= gravity*downGravityMultiplier*coyoteTimeFrames) { 
       velocity.y = -jumpVelocity;
       releasedJump = false;
     }
     jumping = true;
   }
   
   else {
    //Mid-air Boost Jump
    if (releasedJump && !doubleJumpUsed) {
      velocity.y = -boostVelocity;
      doubleJumpUsed = true;
      releasedJump = false;
    }
   }
 }
 
 //If no grapple is targeted, targets the nearest grapple in line of sight
 //If a grapple is targeted, rotates the velocity of the player according to the direction they should be traveling
 // based on their rotation around the grapple
 void grapple() {
   if (grapples.size() != 0) {
     if (targetGrapple == null) {
       if (!grappleChecked) {
         if (grapples.get(0).checkLineOfSight(this)) {
           targetGrapple = grapples.get(0);
         }
         grappleChecked = true;
       }
     }
     else {
       if (!targetGrapple.checkLineOfSight(this)) {
        targetGrapple = null;
        return;
       }
      //Get the angle between the direction of and the direction of force (which is from the position to the grapple point)
      PVector cableVector = targetGrapple.position.copy().sub(position.copy()).normalize();
      float angle = 0;

      //I couldnt figure out the maths for making the player circle concisely but this hacky fix might hack
      if (position.y >= targetGrapple.position.y) {
        if (velocity.x > 0) {
          angle = PVector.angleBetween(cableVector, velocity);
        }
        else {
          angle = PVector.angleBetween(cableVector.copy().mult(-1), velocity);
        }
      }
      else {
        if (velocity.x < 0) { 
        angle = PVector.angleBetween(cableVector, velocity);
        }
       else {
          angle = PVector.angleBetween(cableVector.copy().mult(-1), velocity);
        }
      }
    
    
      //Rotate the velocity so that it is perpendicular to the cable (90-angle rads)
      velocity.rotate(HALF_PI - abs(angle));
      //TODO: Gravity makes things weird by cancelling the swinging hack
      //TODO: Try to hack things out more by adding a clockwise check
      //TODO: Or figure out the real physcics problem and sort that out
      if (abs(velocity.x) < 0.3 && abs(velocity.y) < 0.3) {
         if (velocity.x > 0) {
          velocity.x = -2; 
         }
         else {
          velocity.x = 2; 
         }
         velocity.y = 2;
      }
      else {
        velocity.mult(abs(sin(angle)) * abs(sin(angle)));
      }
    
     }
    
   }
 }
 
 //Changes the position based on velocity, and modifies velocity based on various accelerations
 void integrate() {
   
   if (trampolineLockout > 0) {
    trampolineLockout --; 
   }
   
   //Position Updates
   position.add(velocity);
   
   //Collision with the ground - reset jumping status only if velocity.y is positive (i.e. falling down)
   if (position.y > (500 - radius) && velocity.y > 0) {
     position.y = 500 - radius; 
     velocity.y = 0;
     jumping = false;
     doubleJumpUsed = false;
   }
   
   //Collision with right wall
   if (position.x > (1000 - radius)) {
    position.x = (1000 - radius); 
   }
   
   //Collision with left wall
   if (position.x < radius) {
    position.x = radius; 
   }
   
   groundCollision();
   goalCollision();
   spikeCollision();
   trampolineCollision();
   
   //Velocity Updates
   
   //If velocity to the right is greater than the maxWalkSpeed, decelerate by accelerating to the left
   if (velocity.x > maxWalkSpeed && targetGrapple == null) {
    velocity.x -= walkDeceleration; 
   }
   
   //If velocity to the left is greater than the maxWalkSpeed, decelerate by accelerating to the right
   if (velocity.x < -maxWalkSpeed && targetGrapple == null) {
    velocity.x += walkDeceleration; 
   }
   
   
   //Value of gravity determines fall speed
   float gravityAdded = gravity;
   
   //Stronger gravity if going downwards
   if (velocity.y > 0) {
    gravityAdded *= downGravityMultiplier;
   }
   
   //Stronger gravity if not holding jump on the way up (leads to smaller jump on short presses)
   if (!holdingJump && velocity.y < 0) {
     gravityAdded += gravity;
   }
   
   //Stronger gravity if holding weight
   if (hasWeight) {
    velocity.y += gravity*weightModifier; 
   }
   
   //Add the total acceleration due to gravity to the velocity
   velocity.y += gravityAdded;
 }
 
 //Checks collision with all the ground tiles
 void groundCollision() {
   for (Ground ground: groundPieces) {
     
     //Test Collision with the Block
     boolean belowTopEdge = position.y + radius > ground.position.y;
     boolean aboveBottomEdge = position.y - radius < ground.position.y + ground.rectHeight;
     boolean rightLeftEdge = position.x + radius > ground.position.x;
     boolean leftRightEdge = position.x - radius < ground.position.x + ground.rectWidth;
     
     //If true, colliding with block
     if (belowTopEdge && aboveBottomEdge && rightLeftEdge && leftRightEdge) {
      
       //Test to see which side we have collided with
       
       //Top - Resets Jump
       if (abs(position.y - ground.position.y) <= radius) {
         position.y = ground.position.y - radius;
         
         if (velocity.y > 0) {
          jumping = false;
          doubleJumpUsed = false;
          velocity.y = 0;
         }
       }
       
       //Left
       else if (abs(position.x - ground.position.x) <= radius) {
         position.x = ground.position.x - radius; 
       }
       
       //Right
       else if (abs(position.x - (ground.position.x + ground.rectWidth)) <= radius) {
         position.x = ground.position.x + ground.rectWidth + radius;
       }
       
       //Bottom
       else if (abs(position.y - (ground.position.y + ground.rectHeight)) <= radius) {
         position.y = ground.position.y + ground.rectHeight + radius;
       }
     
       //If none of these are true, you could technically remain inside the block
       //But you would have to move at <30 units per frame, a speed which is extremely unlikely
     }
   }
 }
 
 //Checks to see if the player is colliding with the goal, and if so, calls the change level screen
 void goalCollision() {
   if (position.dist(goal.position) <= goal.iconWidth/2) {
     beatLevel();
   }
 }
 
 //Checks to find the closest spike, and to see if the player is colliding with it
 //If so, reset the player position to the start of the level
 void spikeCollision() {
   Spike closestSpike = null;
   if (spikes.size() == 0) {
    return; 
   }
   
   float lowestDist = 1000000;   
   for (Spike spike: spikes) {
     if (position.dist(spike.position) < lowestDist) {
       lowestDist = position.dist(spike.position);
       closestSpike = spike;
     }
   }
   
   //This probably can't occurd 
   if (closestSpike == null) {
    return; 
   }
   
   //Have already calculated the distance to the closest spike - if its close enough to kill, just use the distance
   if (lowestDist < closestSpike.iconWidth) {
     killPlayer();
   }
   
 }
 
 void trampolineCollision() {
   if (trampolines.size() > 0 && trampolineLockout == 0) {
    for (Trampoline trampoline: trampolines) {
     if (position.dist(trampoline.position) < trampoline.iconWidth) {
      player.velocity.y = -12; 
      trampolineLockout = 50;
     }
    }
   }
 }
 
 
 void draw() {
   fill(red, green, blue);
   ellipse(position.x, position.y, radius*2, radius*2);
   if (targetGrapple != null) {
     fill(0);
     strokeWeight(4);
     line(position.x, position.y, targetGrapple.position.x, targetGrapple.position.y);
     strokeWeight(1);
   }
 }
}
