library tracking;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'positioning.dart';
import 'package:google_maps/google_maps.dart';

@CustomTag('tracking-element')
class TrackingElement extends PolymerElement {
  @observable String gpsStatus = '?';
  @observable String speedAverage = '?';
  @published String borderColor = 'rgb(0,0,0)';
  
  final Positioning positioning = new Positioning();
  GMap map;
  Element mapCanvas;
  TrackingElement.created() : super.created();

  @override
  void attached() {
    super.attached();
    mapCanvas = $['map-canvas'];//shadowRoot.querySelector('#map-canvas');
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
      newPositionInMap();
    }
  }
  
  void newPositionInMap(){
    if (map == null){
      final mapOptions = new MapOptions()
          ..zoom = 17
          ..center = center
          ..mapTypeId = MapTypeId.ROADMAP
          ;
      print("options");
      map = new GMap(mapCanvas, mapOptions);
      print("map");
    }else{
      map.center = center;   
    }
  }
  
  num get lat => positioning.last.lat; 
  num get long => positioning.last.long; 
  LatLng get center => new LatLng(lat, long);
  
  void clear (){
    positioning.clear();
  }
}