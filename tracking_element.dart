library tracking;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'positioning.dart';
import 'map_element.dart';

@CustomTag('tracking-element')
class TrackingElement extends PolymerElement with ChangeNotifier  {
  @reflectable @observable String get gpsStatus => __$gpsStatus; String __$gpsStatus = '?'; @reflectable set gpsStatus(String value) { __$gpsStatus = notifyPropertyChange(#gpsStatus, __$gpsStatus, value); }
  @reflectable @observable String get speedAverage => __$speedAverage; String __$speedAverage = '?'; @reflectable set speedAverage(String value) { __$speedAverage = notifyPropertyChange(#speedAverage, __$speedAverage, value); }
  @reflectable @published String get borderColor => __$borderColor; String __$borderColor = 'rgb(0,0,0)'; @reflectable set borderColor(String value) { __$borderColor = notifyPropertyChange(#borderColor, __$borderColor, value); }
  
  final Positioning positioning = new Positioning();
  TrackingElement.created() : super.created();
  MapElementP mapElement;

  void init(MapElementP mapElement){
    this.mapElement = mapElement;
    window.navigator.geolocation.watchPosition(enableHighAccuracy: true)
      .listen((Geoposition position) {addPosition(position);},
      onError: (PositionError error) => handleError(error)); 
  }
  
  handleError(PositionError  error){
    gpsStatus = error.message;
  }
  
  addPosition(Geoposition geoPosition){
    if (positioning.addPosition(geoPosition)){
      speedAverage = "${positioning.speedAvg}km/h";
      gpsStatus = positioning.last.toString();
      mapElement.addPosition(lat, long);
    }
  }
  
  
  num get lat => positioning.last.lat; 
  num get long => positioning.last.long; 
  
  void clear (){
    positioning.clear();
  }
}