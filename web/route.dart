
import 'dart:math';



class Pos extends Point {
  
  final int timestamp;
  Pos next;
  
  Pos(x , y, ts): super(x, y), timestamp = ts;
  
  void add(P){
    
  }
  
  bool get hasNext => next == null;

  
}

class Route {
  
  final Pos initialPosition;
  Pos endPosition;
  
  Route (this.initialPosition);
  
  bool get hasNext => endPosition == null;
  
}
