//File containing the code to display the introduction, level transition, and ending scenes]

String goalPhrase = null;

void drawIntro() {
  PShape goalShape = loadShape("borgar.svg");
  PShape spikeShape = loadShape("spike.svg");
  shape(goalShape, 50, 50, 75, 75);
  fill(0);
  //Large font
  textSize(32);
  text("7pm trip to the burger place", 150, 100);
  //Medium font
  textSize(20);
  text("It's 7pm, and Customer Number 93 (you) wants to get some burgers", 100, 200);
  text("Use A and D to move left and right, SPACE/w to jump, and U to grapple onto grapple points", 100, 250);
  text("Or you can use the LEFT and RIGHT arrow keys to move, UP to jump and X to grapple", 100, 280);
  text("Avoid spikes and such", 100, 310);
  text("Press U or X to start", 100, 340);
  //Small font
  textSize(12);
  text("(hungry)", 740, 220);
  text("(this)", 865, 310);
  
  ellipse(850, 310, 10, 10);
  fill(backgroundColour);
  ellipse(850, 310, 8, 8);
  fill(0);
}

void drawTransition() {
  fill(0);
  //Large font
  textSize(23);
  if (goalPhrase == null) {
   goalPhrase = goal.getGoalPhrase(); 
  }
  else {
    text(goalPhrase, 50, 100);
  }
  //Medium font
  textSize(20);
  int deathCount = deathCounter[levelCounter];
  String flavourText = "The burger was worth it";
  if (deathCount == 0) {
    flavourText = "Nice job";
  }
  text("You died " + deathCount + " times before beating that level. \n" + flavourText, 150, 150);
  text("Press U or X to continue", 150, 210);
  
  //Small font
  textSize(12);
  text("(level complete)", 680, 120);
}

void drawEnding() {
  fill(0);
  textSize(32);
  text("COMPLETE!", 100, 100);
  int totalDeaths = 0;
  for (int i = 0; i < deathCounter.length; i++) {
   totalDeaths+=deathCounter[i]; 
  }
  textSize(20);
  text("You got the burgers, and died " + totalDeaths + " times doing it", 100, 130);
  if (totalDeaths == 0) {
   text("That's pretty good", 100, 160); 
  }
  else {
   text("Yummy burger", 100, 160); 
  }
  text("Press U or X to retry", 100, 210);
  
}
