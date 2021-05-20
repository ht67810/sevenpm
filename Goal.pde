//The goal object, which increments the level when the player reaches it

static StringList goalPhrases = new StringList();

public class Goal {
  PVector position = new PVector(0, 0);
  
  PShape goalIcon = loadShape("borgar.svg");
  final int iconWidth = 75;
  final int iconHeight = 75;
  
  
  public Goal(int x, int y) {
    this.position.set(x, y);
    
    goalPhrases.append("\"Welcome to the Burger Place, can I take your order?\"");
    goalPhrases.append("\"Can I get a uhhhhhhhhhhhhhhhhhhhhhhh Burger\"");
    goalPhrases.append("\"Order Number 93? Oh, yes, that's mine.\"");
    goalPhrases.append("\"Yeah, can I get a burger hold the bun?\"");
    goalPhrases.append("\"I heard you guys have a secret menu. You don't? That's too bad.\"");
    goalPhrases.append("\"Oh I think you forgot my fries. They're in the bag? Oh, so they are.\"");
    goalPhrases.append("\"Can I get 3 packets of ketchup, and 5 packets of BBQ sauce?\"");
    goalPhrases.append("\"By the way, are you hiring?\"");
    goalPhrases.append("\"Can I get an ice cream? The machine's broken? Not again...\"");
    goalPhrases.append("\"Yeah, sorry, the ice cream machine's broken.\"");
    goalPhrases.append("\"Is the toy in the bag?\"");
    goalPhrases.append("\"Do you have any hotdogs? Just burgers? That makes a lot of sense actually.\"");
    
  }
  void draw() {
    shapeMode(CENTER);
    shape(goalIcon, position.x, position.y, iconWidth, iconHeight);
  }
  
  String getGoalPhrase() {
    return goalPhrases.get(int(random(goalPhrases.size())));
  }
}
