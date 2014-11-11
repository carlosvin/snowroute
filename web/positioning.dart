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
  
}

class Positioning  { 

  final Map<int, Position> positions= new Map<int, Position> ();
  final Map<int, num> distances = new Map<int, num>();
  num totalDistance = 0;
  
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
    if (isEmpty || last != pos){
       if (!isEmpty){
         var distance = calculateDistance(last.lat, last.long, pos.lat, pos.long);
         distances[pos.timestamp] = distance;
         totalDistance += distance; 
       }
       positions[pos.timestamp] = pos;
       return true;
     }else{
       return false;
     }
  }
  
  Position get last=> positions.values.last;
  
  Position get first => positions.values.first;
  
  String get key => "${positions.values.first.timestamp}";
  
  bool get isEmpty => positions.isEmpty;

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

}