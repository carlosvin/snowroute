library tracking;

import 'dart:html';
import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'route.dart';
import 'interfaces.dart';



@CustomTag('tracking-element')
class TrackingElement extends PolymerElement with StateListener, ChangeNotifier{
  @reflectable @observable String get totalDistance => __$totalDistance; String __$totalDistance = '?'; @reflectable set totalDistance(String value) { __$totalDistance = notifyPropertyChange(#totalDistance, __$totalDistance, value); }
  @reflectable @observable String get speedAverage => __$speedAverage; String __$speedAverage = '?'; @reflectable set speedAverage(String value) { __$speedAverage = notifyPropertyChange(#speedAverage, __$speedAverage, value); }
  @reflectable @published String get borderColor => __$borderColor; String __$borderColor = 'rgb(0,0,0)'; @reflectable set borderColor(String value) { __$borderColor = notifyPropertyChange(#borderColor, __$borderColor, value); }
  
  TrackingElement.created() : super.created();

  Route route;
  TrackingListener listener;
  MessageNotifier notifier;
  bool tracking = false;
  
  @override
  void attached(){
    super.attached();
    window.navigator.geolocation.watchPosition(enableHighAccuracy: true)
      .listen((Geoposition position) {_addPosition(position);},
      onError: (PositionError error) => _handleError(error)); 
  }
  
  void init (TrackingListener listener, MessageNotifier notifier){
    this.listener = listener;
    this.notifier = notifier;
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
    notifier.error(error.message);
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
      // TODO anything?
    }
    
    if (listener != null){
      listener.newPosition(geoPosition.coords.latitude, geoPosition.coords.longitude, tracking);        
    }
  }
  
  num get lat => route.last.lat; 
  num get long => route.last.long; 
  
  
}