
public static PVector playerStart = new PVector(0, 0);
public static Goal goal;
public static ArrayList<Ground> groundPieces;
public static ArrayList<Grapple> grapples;
public static ArrayList<Spike> spikes;
public static ArrayList<Trampoline> trampolines;

int numberOfLevels = 0;
  
public void initialiseLevel(int levelIndex) {
  JSONArray levelsArray = loadJSONObject("levels.json").getJSONArray("levels");
  JSONObject level = levelsArray.getJSONObject(levelIndex);
  JSONArray groundArray = level.getJSONArray("groundPieces");
  JSONObject playerStartObj = level.getJSONObject("playerStart");
  JSONObject goalObj = level.getJSONObject("goal");
  JSONArray spikesArray = level.getJSONArray("spikes");
  
  
  groundPieces = new ArrayList();
  grapples = new ArrayList();
  spikes = new ArrayList();
  trampolines = new ArrayList();
  
  //Retrieves all the ground pieces
  for (int i = 0; i < groundArray.size(); i++) {
   JSONObject groundPiece = groundArray.getJSONObject(i);
   int x = groundPiece.getInt("x");
   int y = groundPiece.getInt("y");
   int gWidth = groundPiece.getInt("width");
   int gHeight = groundPiece.getInt("height");
   groundPieces.add(new Ground(x, y, gWidth, gHeight));
  }
  
  //Retrieves all the spikes
  for (int i = 0; i < spikesArray.size(); i++) {
   JSONObject spike = spikesArray.getJSONObject(i);
   int xStart = spike.getInt("xStart");
   int xEnd = spike.getInt("xEnd");
   int y = spike.getInt("y");
   int rotation = spike.getInt("rotation");
   for (int x = xStart; x <= xEnd; x+= 25) {
    spikes.add(new Spike(x, y, rotation)); 
   }
  }
  
  //Retrieves all the grapples if any
  if (!level.isNull("grapples")) {
    JSONArray grapplesArray = level.getJSONArray("grapples");
    for (int i = 0; i < grapplesArray.size(); i++) {
     JSONObject grapple = grapplesArray.getJSONObject(i);
     int x = grapple.getInt("x");
     int y = grapple.getInt("y");
     grapples.add(new Grapple(x, y));
    }
  }
  
  //Retrieves all the trampolines if any
  if (!level.isNull("trampolines")) {
   JSONArray trampolinesArray = level.getJSONArray("trampolines");
   for (int i = 0; i < trampolinesArray.size(); i++) {
    JSONObject trampoline = trampolinesArray.getJSONObject(i);
    int x = trampoline.getInt("x");
    int y = trampoline.getInt("y");
    trampolines.add(new Trampoline(x, y));
   }
  }
  
  //Sets player spawn
  int spawnX = playerStartObj.getInt("x");
  
  int spawnY = playerStartObj.getInt("y");
  playerStart.set(spawnX, spawnY);
  
  //Sets the goal location
  int goalX = goalObj.getInt("x");
  int goalY = goalObj.getInt("y");
  goal = new Goal(goalX, goalY);
}

public int getLevelCount() {
 JSONArray levelsArray = loadJSONObject("levels.json").getJSONArray("levels");
 return levelsArray.size();
}
