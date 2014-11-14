library tracking;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'dart:html';
import 'positioning.dart';

@CustomTag('tracking-element')
class TrackingElement extends PolymerElement {
  @observable String gpsStatus = '?';
  @observable String speedAverage = '?';
  @published String borderColor = 'rgb(0,0,0)';
  
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
      context.callMethod('addPosition', [geoPosition.coords.latitude, geoPosition.coords.longitude]);
    }
  }
  
  void clear (){
    positioning.clear();
  }
}