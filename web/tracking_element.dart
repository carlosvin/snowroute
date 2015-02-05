library tracking;

import 'dart:html';
import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'package:snowroute/route.dart';
import 'package:snowroute/interfaces.dart';
import 'data_sync.dart';


@CustomTag('tracking-element')
class TrackingElement extends PolymerElement with StateListener{
  @observable String totalDistance = '?';
  @observable String speedAverage = '?';
  @published String borderColor = 'rgb(0,0,0)';
  
  TrackingElement.created() : super.created();

  Route _route;
  TrackingListener _listener;
  MessageNotifier _notifier;
  bool _tracking = false;
  FirebaseConnector _db;
  
  @override
  void attached(){
    super.attached();
    window.navigator.geolocation.watchPosition(enableHighAccuracy: true)
      .listen((Geoposition position) {_addPosition(position);},
      onError: (PositionError error) => _handleError(error)); 
  }
  
  void init (TrackingListener listener, MessageNotifier notifier, FirebaseConnector db){
    this._listener = listener;
    this._notifier = notifier;
    this._db = db;
  }
  
  @override
  void onStateStarted(){
    _tracking = true;
    _addPositionCoords(50.0, 40.0);
  }
  
  @override
  void onStateStopped (){
    _addPositionCoords(55.0, 44.0);
    _tracking = false;
    _listener.stopTracking();
    _save();
    _route = null;
  }
  
  @override
  void onStatePaused(){
    _tracking = false;
  }
  
  void _save(){
    if (_route == null || _route.isTooShort){
      _notifier.error("The practice is too short");      
    }else{
      _notifier.info("Saving ${_route.id }");
      _db.save(_route);
      _notifier.info("Saved ${_route.id }");
    }
  }
  
  void _handleError(PositionError  error){
    _notifier.error(error.message);
  }
  
  void _addPosition(Geoposition geoPosition){
    _addPositionCoords(geoPosition.coords.latitude, geoPosition.coords.longitude);
  }
  
  void _addPositionCoords(num lat, num long){
    if (_tracking){
      if (_route == null){
        _route = new Route.fromCoords(lat, long);
      }else{
        _route.add(lat, long);
      }
      totalDistance = "${_route.distance.round()}m";
      speedAverage = "${(_route.speedAvg * 3.6).toStringAsFixed(2)}km/h";
    }else{
      _notifier.warn("It is not tracking");
    }
    
    if (_listener != null){
      _listener.newPosition(lat, long, _tracking);        
    }
  }
  
  num get lat => _route.last.lat; 
  num get long => _route.last.long; 
  
  
}