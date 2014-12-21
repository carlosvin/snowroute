library tracking;

import 'dart:html';
import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'route.dart';
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
  
  Route route;
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
    tracking = true;
  }
  
  @override
  void onStateStopped (){
    tracking = false;
    route = null;
    listener.stopTracking();
  }
  
  void onStatePaused(){
    tracking = false;
  }
  
  void _handleError(PositionError  error){
    gpsStatus = error.message;      
  }
  
  void _addPosition(Geoposition geoPosition){
    if (tracking){
      if (route == null){
        route = new Route.fromCoords(geoPosition.coords.latitude, geoPosition.coords.longitude);
      }else{
        route.add(geoPosition.coords.latitude, geoPosition.coords.longitude);
      }
      totalDistance = "${route.distance.round()}m";
      speedAverage = "${(route.speedAvg * 3.6).toStringAsFixed(2)}km/h";
    }else{
      gpsStatus = "Not tracking";
    }
    
    if (listener != null){
      listener.newPosition(geoPosition.coords.latitude, geoPosition.coords.longitude, tracking);        
    }
  }
  
  num get lat => route.last.lat; 
  num get long => route.last.long; 
  
  
}