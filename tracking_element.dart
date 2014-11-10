library tracking;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'positioning.dart';

@CustomTag('tracking-element')
class TrackingElement extends PolymerElement with ChangeNotifier  {
  @reflectable @observable String get gpsStatus => __$gpsStatus; String __$gpsStatus = '?'; @reflectable set gpsStatus(String value) { __$gpsStatus = notifyPropertyChange(#gpsStatus, __$gpsStatus, value); }
  @reflectable @observable String get speedAverage => __$speedAverage; String __$speedAverage = '?'; @reflectable set speedAverage(String value) { __$speedAverage = notifyPropertyChange(#speedAverage, __$speedAverage, value); }
  
  final Positioning positioning = new Positioning();

  TrackingElement.created() : super.created();

  @override
  void attached() {
    super.attached();
    window.navigator.geolocation.watchPosition(enableHighAccuracy: true)
      .listen((Geoposition position) {addPosition(position);},
      onError: (PositionError error) => handleError(error));
  }
  
  @override
  void detached() {
    super.detached();
    clear();
  }  
  
  handleError(PositionError  error){
    gpsStatus = error.message;
  }
  
  addPosition(Geoposition geoPosition){
    if (positioning.addPosition(geoPosition)){
      speedAverage = "${positioning.speedAvg}km/h";
      gpsStatus = positioning.last.toString();

    }

  }
  
  void clear (){
    positioning.clear();
  }
}