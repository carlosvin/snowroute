library tracking;

import 'dart:html';
import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'positioning.dart';
import 'state_machine.dart';

abstract class TrackingListener {
  void newPosition(num lat, num long, bool tracking);
  void stopTracking();
}

@CustomTag('tracking-element')
class TrackingElement extends PolymerElement with StateListener{
  @observable String gpsStatus = '?';
  @observable String totalDistance = '?';
  @observable String speedAverage = '?';
  @published String borderColor = 'rgb(0,0,0)';
  
  final Positioning positioning = new Positioning();
  TrackingElement.created() : super.created();
  TrackingListener listener;
  bool tracking = false;
  
  @override
  void attached(){
    super.attached();
    window.navigator.geolocation.watchPosition(enableHighAccuracy: true)
      .listen((Geoposition position) {_addPosition(position);},
      onError: (PositionError error) => _handleError(error)); 
  }
  
  @override
  void onStateStarted(){
    positioning.clear();
    tracking = true;
  }
  
  @override
  void onStateStopped (){
    tracking = false;
    positioning.clear();
    listener.stopTracking();
  }
  
  void onStatePaused(){
    tracking = false;
  }
  
  void _handleError(PositionError  error){
    gpsStatus = error.message;      
  }
  
  void _addPosition(Geoposition geoPosition){
    if (positioning.addPosition(geoPosition.coords.latitude, geoPosition.coords.longitude, geoPosition.timestamp)){
      totalDistance = "${positioning.totalDistance.toStringAsPrecision(2)}km";
      speedAverage = "${positioning.speedAvg.toStringAsPrecision(2)}km/h";
      gpsStatus = positioning.last.toString();
    }
    
    if (listener != null){
      listener.newPosition(geoPosition.coords.latitude, geoPosition.coords.longitude, tracking);        
    }
  }
  
  num get lat => positioning.last.lat; 
  num get long => positioning.last.long; 
  
  
}