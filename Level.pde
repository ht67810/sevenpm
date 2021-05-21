
public static PVector playerStart = new PVector(0, 0);
public static Goal goal;
public static ArrayList<Ground> groundPieces;
public static ArrayList<Grapple> grapples;
public static ArrayList<Spike> spikes;
public static ArrayList<Trampoline> trampolines;
public static ArrayList<CrumbleKey> crumbleKeys;

public static Weight weight;

int numberOfLevels = 0;
  
public void initialiseLevel(int levelIndex) {
  JSONObject level = loadJSONObject("level" + levelIndex+".json").getJSONObject("level");
  JSONArray groundArray = level.getJSONArray("groundPieces");
  JSONObject playerStartObj = level.getJSONObject("playerStart");
  JSONObject goalObj = level.getJSONObject("goal");
  JSONArray spikesArray = level.getJSONArray("spikes");
  
  
  groundPieces = new ArrayList();
  grapples = new ArrayList();
  spikes = new ArrayList();
  trampolines = new ArrayList();
  crumbleKeys = new ArrayList();
  weight = null;
  
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
   //Horizontal row of spikes
   if (!spike.isNull("xStart")) {
     int xStart = spike.getInt("xStart");
     int xEnd = spike.getInt("xEnd");
     int y = spike.getInt("y");
     int rotation = spike.getInt("rotation");
     for (int x = xStart; x <= xEnd; x+= 25) {
       spikes.add(new Spike(x, y, rotation)); 
     }
   }
   //Vertical column of spikes
   else {
     int x = spike.getInt("x");
     int yStart = spike.getInt("yStart");
     int yEnd = spike.getInt("yEnd");
     int rotation = spike.getInt("rotation");
     for (int y = yStart; y <= yEnd; y+=25) {
      spikes.add(new Spike(x, y, rotation)); 
     }
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
  
  //Retrieves all the crumble blocks and keys if any
  if (!level.isNull("crumbles")) {
   JSONArray blocks = level.getJSONObject("crumbles").getJSONArray("blocks");
   for (int i = 0; i < blocks.size(); i++) {
     JSONObject block = blocks.getJSONObject(i);
     int x = block.getInt("x");
     int y = block.getInt("y");
     int w = block.getInt("width");
     int h = block.getInt("height");
    groundPieces.add(new CrumbleBlock(x, y, w, h));
   }
   
   JSONArray keys = level.getJSONObject("crumbles").getJSONArray("keys");
   for (int i = 0; i < keys.size(); i++) {
    JSONObject k = keys.getJSONObject(i);
    int x = k.getInt("x");
    int y = k.getInt("y");
    crumbleKeys.add(new CrumbleKey(x, y));
   }
  }
  
  if (!level.isNull("weight")) {
   JSONObject weightObj = level.getJSONObject("weight");
   int x = weightObj.getInt("x");
   int y = weightObj.getInt("y");
   weight = new Weight(x, y);
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

public void resetLevel() {
  JSONObject level = loadJSONObject("level" + levelCounter +".json").getJSONObject("level");
  JSONArray groundArray = level.getJSONArray("groundPieces");
  groundPieces = new ArrayList();
  crumbleKeys = new ArrayList();
  
  //Retrieves all the ground pieces
  for (int i = 0; i < groundArray.size(); i++) {
   JSONObject groundPiece = groundArray.getJSONObject(i);
   int x = groundPiece.getInt("x");
   int y = groundPiece.getInt("y");
   int gWidth = groundPiece.getInt("width");
   int gHeight = groundPiece.getInt("height");
   groundPieces.add(new Ground(x, y, gWidth, gHeight));
  }
  
  //Retrieves all the crumble blocks and keys if any
  if (!level.isNull("crumbles")) {
   JSONArray blocks = level.getJSONObject("crumbles").getJSONArray("blocks");
   for (int i = 0; i < blocks.size(); i++) {
     JSONObject block = blocks.getJSONObject(i);
     int x = block.getInt("x");
     int y = block.getInt("y");
     int w = block.getInt("width");
     int h = block.getInt("height");
     groundPieces.add(new CrumbleBlock(x, y, w, h));
   }
   
   JSONArray keys = level.getJSONObject("crumbles").getJSONArray("keys");
   for (int i = 0; i < keys.size(); i++) {
    JSONObject k = keys.getJSONObject(i);
    int x = k.getInt("x");
    int y = k.getInt("y");
    crumbleKeys.add(new CrumbleKey(x, y));
   }
  }
  
  //Retrieves the weight if there is one
  if (!level.isNull("weight")) {
   JSONObject weightObj = level.getJSONObject("weight");
   int x = weightObj.getInt("x");
   int y = weightObj.getInt("y");
   weight = new Weight(x, y);
  }
}

//Returns the number of files in the data folder - 2
//Because there are 3 non-level files in there
public int getLevelCount() {
  File file = new File(dataPath(""));
  String[] listPath = file.list();
  return listPath.length-3;
}
