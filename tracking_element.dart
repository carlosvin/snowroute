library tracking;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'positioning.dart';
import 'state_machine.dart';

abstract class TrackingListener {
  void newPosition(num lat, num long, bool tracking);
  void stopTracking();
}

@CustomTag('tracking-element')
class TrackingElement extends PolymerElement with StateListener, ChangeNotifier{
  @reflectable @observable String get gpsStatus => __$gpsStatus; String __$gpsStatus = '?'; @reflectable set gpsStatus(String value) { __$gpsStatus = notifyPropertyChange(#gpsStatus, __$gpsStatus, value); }
  @reflectable @observable String get speedAverage => __$speedAverage; String __$speedAverage = '?'; @reflectable set speedAverage(String value) { __$speedAverage = notifyPropertyChange(#speedAverage, __$speedAverage, value); }
  @reflectable @published String get borderColor => __$borderColor; String __$borderColor = 'rgb(0,0,0)'; @reflectable set borderColor(String value) { __$borderColor = notifyPropertyChange(#borderColor, __$borderColor, value); }
  
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
    if (positioning.addPosition(geoPosition)){
      speedAverage = "${positioning.speedAvg}km/h";
      gpsStatus = positioning.last.toString();
    }
    
    if (listener != null){
      listener.newPosition(geoPosition.coords.latitude, geoPosition.coords.longitude, tracking);        
    }
  }
  
  num get lat => positioning.last.lat; 
  num get long => positioning.last.long; 
  
  
}