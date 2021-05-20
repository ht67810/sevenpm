Player player;
final int windowWidth = 1000;
final int windowHeight = 500;
final static int backgroundColour = 220;

final PVector initialVelocity = new PVector(0, 0);

int levelCounter;
int[] deathCounter;

//If the intro should be shown
boolean isIntro = true;
//If the level transition should be shown
boolean isTransition = false;
//If the ending should be shown
boolean isEnding = false;

void setup() {
  size(1000, 500);
  isIntro = true;
  isTransition = false;
  isEnding = false;
  numberOfLevels = getLevelCount();
  player = new Player();
  levelCounter = 0;
  deathCounter = new int[numberOfLevels];
  for (int i = 0; i < deathCounter.length; i++) {
   deathCounter[i] = 0; 
  }
}

void draw() {
 background(backgroundColour);
 if (isIntro) {
  drawIntro(); 
 }
 else if (isTransition) {
  drawTransition(); 
 }
 else if (isEnding) {
  drawEnding(); 
 }
 else {
   player.integrate();
   player.doMovement();
 
   for(Ground ground: groundPieces) {
     ground.draw();
   }
 
   for (Grapple grapple: grapples) {
     grapple.draw(); 
   }
 
   for (Spike spike: spikes) {
     spike.draw(); 
   }
   
   for (Trampoline trampoline: trampolines) {
    trampoline.draw(); 
   }
   player.draw();
   goal.draw();
 }
}

void keyPressed() {
 
 if (isIntro) {
  if (key==ENTER || key==RETURN || key == 'x' || key == 'u') {
    isIntro = false;
    initialiseLevel(levelCounter);
    player.position.set(playerStart);
  }
 }
 else if (isTransition) {
  if (key==ENTER || key==RETURN || key == 'x' || key == 'u') {
   levelCounter++;
   isTransition = false;
   goalPhrase = null;
   //Game has been beaten - end screen
  if (levelCounter == numberOfLevels) {
    //Temp
    isEnding = true;
  }
  else {
   initialiseLevel(levelCounter);
   player.position.set(playerStart);
  }
   
  }
 }
 
 else if (isEnding) {
  if (key==ENTER || key==RETURN || key == 'x' || key == 'u') {
   isEnding = false;
   setup();
  }
 }
 if (key == 'a') {
   player.movingLeft = true;
 }
 
 if (key == 'd') {
  player.movingRight = true; 
 }
 
 if (key == ' ' || key == 'w') {
  player.holdingJump = true; 
 }
 
 if (key == 'u' || key=='x') {
  player.holdingGrapple = true; 
 }
 
 if (key == CODED) {
  if (keyCode == UP) {
   player.holdingJump = true; 
  }
  if (keyCode == LEFT) {
   player.movingLeft = true; 
  }
  if (keyCode == RIGHT) {
   player.movingRight = true; 
  }
 }
}

void keyReleased() {
 if (key == 'a') {
  player.movingLeft = false;
 }
 
 if (key == 'd') {
  player.movingRight = false; 
 }
 
 if (key == ' ' || key == 'w') {
  player.holdingJump = false; 
  player.releasedJump = true;
 }
 
 if (key == 'u' || key == 'x') {
  player.holdingGrapple = false; 
  player.targetGrapple = null;
  player.grappleChecked = false;
 }
 
 if (key == CODED) {
  if (keyCode == UP) {
    player.holdingJump = false;
    player.releasedJump = true;
  }
  if (keyCode == LEFT) {
   player.movingLeft = false; 
  }
  if (keyCode == RIGHT) {
   player.movingRight = false; 
  }
 }
}

void beatLevel() {
 isTransition = true;
 
 //Prevents accidentally reactivating the goal on multiple frames
 player.position.set(0, 0);
 player.velocity.set(initialVelocity);
}

void killPlayer() {
  deathCounter[levelCounter]++;
  player.position.set(playerStart);
  player.velocity.set(initialVelocity);
  player.targetGrapple = null;
} 
