
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
  /*
  bool operator ==(Pos b) {
    return lat == b.lat && long == b.long && timestamp== b.timestamp && _next == b._next; 
  }
  
  get hashCode {
    int prim = 31;
    if (hasNext){
      prim = prim * next.hashCode;
    }
    return prim* (lat.hashCode + long.hashCode + timestamp.hashCode);
  }*/
}


class Route  {
  
  static final int MIN_DURATION_SECONDS = 10;

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
    routeStr.split('\n').forEach((s) => _deserializePosition(s) );
  }
  
  void _init(Pos ini){
    this._ini = ini;
    this._last = ini;
  }
  
  void _deserializePosition(String posStr){
    List<String> values = posStr.split(',');
    
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
      strb.writeln("${pos.lat},${pos.long},${pos.timestamp.millisecondsSinceEpoch}");      
    }
    return strb.toString();
  }


  void _add(num x, num y, DateTime time){
    Pos p;
    if (_last == _ini){
      p = new Pos(x, y, time, _ini);
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
  Duration get duration => last.timestamp.difference(_ini.timestamp);
  
  num get speedAvg => distance / duration.inSeconds;
  
  String get key => _ini.timestamp.toString();
  
  bool get isTooShort => duration.inSeconds < MIN_DURATION_SECONDS;
}
