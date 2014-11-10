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
  
  Positioning.fromRaw(key, Map value){
    positions.addAll( value['positions']);
    
  }
  
  // Serialize this to an object (a Map) to insert into the database.
  Map toRaw() {
    return {
      'timestamp': positions.keys.first,
      'positions': positions
    };
  }

  bool addPosition(Geoposition coords){
    Position pos = new Position.fromGeoposition(coords);
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