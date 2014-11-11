import 'dart:html';
import 'dart:math';

final EARTH_RADIUS = 6371; // km

class Position {
  final double long;
  final double lat;
  final int timestamp;
  
  Position(this.long, this.lat, this.timestamp){
    
  }
  
  Position.fromGeoposition(Geoposition pos): 
    long = pos.coords.longitude,
    lat = pos.coords.latitude,
    timestamp = pos.timestamp;
  
  
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
  
 /* bool operator ==(Position p){
    return long == p.long && lat == p.lat;
  }*/
  
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
  

  bool addPosition(Geoposition coords){
    return add(new Position.fromGeoposition(coords));
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
      positions[pos.timestamp] = pos;
      var distance = calculateDistance(last.lat, last.long, pos.lat, pos.long);
      distances[pos.timestamp] = distance;
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
    if (isEmpty){
      return 0;
    }else{
      return totalDistance / positions.length;      
    }
  }

  num calculateDistance(num lat1, num lon1, num lat2, num lon2) {
    num latDiff = lat2 - lat1;
    num lonDiff = lon2 - lon1;

    var a = pow(sin(latDiff / 2), 2) + cos(lat1) * cos (lat2) * pow(sin(lonDiff / 2), 2);
    
    var angularDistance = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return EARTH_RADIUS * angularDistance;
  }
  
  String get duration => "${(last.timestamp - first.timestamp)/1000}";

}