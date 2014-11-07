import 'dart:html';
import 'dart:math';

class Positioning { 
  static final EARTH_RADIUS = 6371; // km

  final Map<DateTime, Geoposition> positions= new Map<DateTime, Geoposition> ();
  final Map<DateTime, num> distances = new Map<DateTime, num>();
  num totalDistance = 0;
  
  bool addPosition(Geoposition position){
    if (positions.isEmpty || positions.values.last.coords != position.coords){
      var now  = new DateTime.now();
      if (!isEmpty()){
        var distance = calculateDistance(last().coords.latitude, last().coords.longitude, position.coords.latitude, position.coords.longitude);
        distances[now] = distance;
        totalDistance += distance; 
      }
      positions[now] = position;
      return true;
    }else{
      return false;
    }
  }
  
  Geoposition last(){
    return positions.values.last;
  }
  
  bool isEmpty(){
    return positions.isEmpty;  
  }
  
  void clear(){
    positions.clear();
  }
  
  get speedAvg{
    if (isEmpty()){
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