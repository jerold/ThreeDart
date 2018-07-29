part of craft;

/// BlockType is the enums for all the voxel block types
class BlockType {
  BlockType._();

  //====================================
  // Special blocks
  //====================================

  /// Default nothing block, works as air
  static const int Air = 0;
  
  /// Transparent water block
  static const int Water = 1;
  
  /// Invisible wall used to block players from leaving the island
  static const int Boundary = 2;

  //====================================
  // Solid blocks
  //====================================
  
  /// Brown on all sides dirt block
  static const int Dirt = 100;

  /// Turf block has grass turf on the top of dirt
  static const int Turf = 101;

  /// Basic grey rock block
  static const int Rock = 102;

  /// Off-white sand block beside water
  static const int Sand = 103;
  
  /// Dry leaves is turf with some leaves on it
  static const int DryLeaves = 104;

  /// Trunk block of a tree
  static const int Trunk = 105;
  
  /// Block of grey bricks
  static const int Brick = 106;
  
  /// Red reflective solid block, like ruby
  static const int RedShine = 107;
  
  /// White reflective solid block, like silver
  static const int WhiteShine = 108;

  /// Yellow reflective solid block, like gold
  static const int YellowShine = 109;

  /// Black reflective solid block, like obsidian
  static const int BlackShine = 110;

  /// A block of leaves on the top of the tree
  static const int Leaves = 111;
  
  //====================================
  // Open blocks
  //====================================

  /// Grass is an alpha textured plant for grass
  static const int Grass = 200;
  
  /// Fern is an alpha textured plant for a fern
  static const int Fern = 201;
  
  /// Flowers is an alpha textured plant the small white flower
  static const int WhiteFlower = 202;
  
  /// Flowers is an alpha textured plant the blue tuffs flower 
  static const int BlueFlower = 203;

  /// Flowers is an alpha textured plant the red flower
  static const int RedFlower = 204;

  /// Mushroom is a special model for the mushrooms
  static const int Mushroom = 205;

  //====================================

  /// Placeable blocks in the order to show in the hand.
  static final List<int> PlaceableBlocks = [
    Water,
    Dirt,
    Turf,
    Rock,
    Sand ,
    DryLeaves,
    Trunk,
    Brick,
    RedShine,
    WhiteShine,
    YellowShine,
    BlackShine,
    Leaves,
    Grass,
    Fern,
    WhiteFlower,
    BlueFlower,
    RedFlower,
    Mushroom];

  /// string gets the string for the given block type value.
  static String string(int value) {
    switch(value) {
      case Air:         return "air";
      case Water:       return "water";
      case Boundary:    return "boundary";
      
      case Dirt:        return "dirt";
      case Turf:        return "turf";
      case Rock:        return "rock";
      case Sand:        return "sand"; 
      case DryLeaves:   return "dryLeaves";
      case Trunk:       return "trunk";
      case Brick:       return "brick";
      case RedShine:    return "redShine";
      case WhiteShine:  return "whiteShine";
      case YellowShine: return "yellowShine";
      case BlackShine:  return "blackShine";
      case Leaves:      return "leaves";

      case Grass:       return "grass";
      case Fern:        return "fern";
      case WhiteFlower: return "whiteFlower";
      case BlueFlower:  return "blueFlower";
      case RedFlower:   return "redFlower";
      case Mushroom:    return "mushroom";
    }
    return "undefined";
  }

  /// hard determines if the given block type can not be walked through.
  static bool hard(int value) {
    return solid(value) || (value == Boundary);
  }

  /// solid determines if the given block type can not be seen through.
  static bool solid(int value) {
    return (value >= Dirt) && (value <= Leaves);
  }

  /// open determines if the given block type can be seen through.
  static bool open(int value) {
    return ((value >= Grass) && (value <= Mushroom)) || (value == Boundary);
  }

  /// Determines if the side of the block should be drawn.
  static bool drawSide(int value, int neighbor) {
    if (value == neighbor) return false;
    if (neighbor == Air) return true;
    if (value == Water) return open(neighbor);
    return !open(value) && ((neighbor == Water) || open(neighbor));
  }
}
