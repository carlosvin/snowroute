library route;

import 'dart:math';
import 'interfaces.dart';

final EARTH_RADIUS = 6371000; // m

class Pos {
  
  final DateTime timestamp;
  final Pos prev;
  final num lat;
  final num long;
  num _distancePrev, _distanceNext;
  Pos _next;
  
  Pos(this.lat,this.long, this.timestamp, this.prev){
    if (prev == null){
      _distancePrev = 0;
    }else{
      _distancePrev = prev.distanceTo(this);
      prev.next = this;
    }
  }
 
  void set next(Pos n) {
    _next = n;
    _distanceNext = distanceTo(_next);
  }
  
  Pos get next => _next;
  
  bool get hasNext => _next != null;
  
  num get distancePrev => _distancePrev;
  num get distanceNext=> _distanceNext;
  
  static num toRadians(num i){
    return i * PI/180;
  }
  
  /**
   * @return distance from this to b in meters
   */
  num distanceTo (Pos b){
     num dlon = toRadians(b.long - long);
     num dlat = toRadians(b.lat - lat);
     
     num a = pow(sin(dlat/2), 2) + cos(toRadians(lat)) * cos(toRadians(b.lat)) * pow(sin(dlon/2),2); 
     num c = 2 * atan2( sqrt(a), sqrt(1-a) ); 
     return EARTH_RADIUS * c;
   }

}


class Route extends Identifiable {
  
  static final int MIN_DURATION_SECONDS = 10;
  static final String POSITION_SEPARATOR = ";";
  static final String ELEMENTS_SEPARATOR = ",";

  Pos _ini;
  Pos _last;
  num _distance = 0;
  
  Route (Pos ini){
    _init(ini);
  }
  
  Route.fromCoords (num  lat, num long){
    _init(new Pos(lat, long, new DateTime.now() ,null));
  }
  
  Route.deserialize (String routeStr){
    routeStr.split(POSITION_SEPARATOR).forEach((s) => _deserializePosition(s) );
  }
  
  Route.fromMap(Map map){
    map.forEach((k,v) => _add(v['lat'], v['long'], new DateTime.fromMillisecondsSinceEpoch( v['timestamp'])));
  }
  
  Map toMap (){
    Map map = new Map();
    for (Pos pos=_ini; pos != null; pos = pos.next) {
      map[pos.timestamp.millisecondsSinceEpoch.toString()] = {'timestamp': pos.timestamp.millisecondsSinceEpoch, 'lat': pos.lat, 'long': pos.long };
    }
    return map;
  }
 
  void _init(Pos ini){
    this._ini = ini;
    this._last = ini;
  }
  
  void _deserializePosition(String posStr){
    List<String> values = posStr.split(ELEMENTS_SEPARATOR);
    
    if (values.length == 3){
      num lat = double.parse(values[0]);
      num long = double.parse(values[1]);
      DateTime timestamp = new DateTime.fromMillisecondsSinceEpoch(int.parse(values[2]));
      
      if (_ini == null){
        _init(new Pos(lat, long, timestamp, null));
      }else{
        _add(lat, long, timestamp);
      }
    } 
  }
  
  String serialize (){
    StringBuffer strb = new StringBuffer();
    for (Pos pos=_ini; pos != null; pos = pos.next) {
      strb.write("${pos.lat}$ELEMENTS_SEPARATOR${pos.long}$ELEMENTS_SEPARATOR${pos.timestamp.millisecondsSinceEpoch}$POSITION_SEPARATOR");      
    }
    return strb.toString();
  }

  void _add(num x, num y, DateTime time){
    if (_ini == null){
      _init(new Pos(x, y, time, null));
    }else{
      Pos p;
      if (_last == _ini){
        p = new Pos(x, y, time, _ini);
      }else{
        p = new Pos(x, y, time, _last);
      }
      _distance = _distance + p.distancePrev;
      _last = p;
    }
  }
  
  void add(num x, num y){
    _add(x, y , new DateTime.now());
  }
  
  Pos get last => _last;
  
  /**
   * @return distance in meters
   */
  num get distance => _distance;
  
  /**
   * @return total duration of route
   */
  Duration get duration => last.timestamp.difference(_ini.timestamp);
  
  num get speedAvg => distance / duration.inSeconds;
    
  bool get isTooShort => duration.inSeconds < MIN_DURATION_SECONDS;
  
  @override
  get id => _ini.timestamp.millisecondsSinceEpoch.toString();
}
