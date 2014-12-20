
import 'dart:math';

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
  
  bool get hasNext => _next == null;
  
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


class Route {
  
  final Pos ini;
  Pos _last;
  num _distance = 0;
  
  Route (this.ini){
    this._last = ini;
  }
  
  Route.fromCoords (num  lat, num long): this.ini = new Pos(lat, long, new DateTime.now() ,null){
    this._last = ini;
  }
  
  void _add(num x, num y, DateTime time){
    Pos p;
    if (_last == ini){
      p = new Pos(x, y, time, ini);
    }else{
      p = new Pos(x, y, time, _last);
    }
    _distance = _distance + p.distancePrev;
    _last = p;
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
  Duration get duration => last.timestamp.difference(ini.timestamp);
  
  num get speedAvg => distance / duration.inSeconds;
}
