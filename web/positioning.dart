import 'dart:math';

final EARTH_RADIUS = 6371; // km
final EARTH_RADIUS2 = EARTH_RADIUS * 2; // km

class Position {
  final double long;
  final double lat;
  final int timestamp;
  
  Position(this.long, this.lat, this.timestamp){
    
  }
  
  Position.deserialize(String str):
    long = double.parse(str.split(',').elementAt(0)),
    lat = double.parse(str.split(',').elementAt(1)),
    timestamp = int.parse(str.split(',').elementAt(2));
  
  String serialize(){
    return "$lat,$long,$timestamp";
  }
  
  String toString(){
    return "($lat, $long) at ${new DateTime.fromMillisecondsSinceEpoch(timestamp)}";
  }
  
  bool isSamePlace (Position p){
    return long == p.long && lat == p.lat;
  }

  static num toRadians(num x){
    return x * (PI)/180;
  }
  
  num getDistanceTo (Position b){
    num dlon = toRadians(b.long - long);
    num dlat = toRadians(b.lat - lat);
    
    num a = pow(sin(dlat/2), 2) + cos(toRadians(lat)) * cos(toRadians(b.lat)) * pow(sin(dlon/2),2); 
    num c = 2 * atan2( sqrt(a), sqrt(1-a) ); 
    return EARTH_RADIUS * c;
  }
  
}

class Positioning  { 

  final Map<int, Position> positions= new Map<int, Position> ();
  final Map<int, num> distances = new Map<int, num>();
  
  Positioning(){
    
  }
  
  Positioning.deserialize(String str){
    str.split('\n').forEach((s) => _deserializePosition(s) );
  }
  
  void _deserializePosition(String s){
    try {
      if (!s.isEmpty && add(new Position.deserialize(s))){
        print("Deserialized position $s");
      }else{
        print("Cannot add $s");
      }
    }catch(e){
      // TODO
      print("$s <- $e");
    }
  }
  
  String serialize (){
    StringBuffer strb = new StringBuffer();
    positions.forEach((k,v) => strb.writeln(v.serialize()));
    return strb.toString();
  }
  

  bool addPosition(double lat, double long, int ts){
    return add(new Position(lat, long , ts));
  }
  
  bool add(Position pos){
    if (isEmpty){
      positions[pos.timestamp] = pos;
    } else {
      if (last.isSamePlace(pos)){
        final lastKeyToRemove = positions.keys.last;
        positions.remove(lastKeyToRemove);
        distances.remove(lastKeyToRemove); 
      }
      distances[pos.timestamp] = last.getDistanceTo(pos);
      positions[pos.timestamp] = pos;
    }
    return true;
  }
  
  Position get last=> positions.values.last;
  
  Position get first => positions.values.first;
  
  String get key => "${positions.values.first.timestamp}";
  
  bool get isEmpty => positions.isEmpty;
  
  num get totalDistance => distances.values.fold(0, (prev, element) => prev + element);

  void clear(){
    positions.clear();
  }
  
  num get speedAvg {
    if (positions.length <= 1){
      return 0;
    }else{
      return totalDistance / durationH;      
    }
  }
  
  num get duration {
      if (isEmpty) {
        return 0;
      }
      else {
        return (last.timestamp - first.timestamp)/1000;
      }
  }
  num get durationH => duration / 3600;

}