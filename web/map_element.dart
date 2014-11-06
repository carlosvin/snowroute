import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:html';
import 'positioning.dart';


@CustomTag('map-element')
class MapElement extends PolymerElement {

  @observable final Positioning positioning = new Positioning();
  @observable String error = null;
  
  GMap gmap;
  Polyline line;
  Element canvasMap;
  
  MapElement.created() : super.created();

  @override
  void attached() {
    super.attached();
    canvasMap = $['canvas_map'];
    initMap();
    window.navigator.geolocation.watchPosition(enableHighAccuracy: true)
          .listen(
              (Geoposition position) {addPosition(position);},
              onError: (error) => handleError(error));
  }
  
  addPosition(Geoposition position){
    if (error != null){
      error = null;
    }
    if (positioning.addPosition(position)){
      drawMap(position);
    }
  }
  
  void drawMap(Geoposition position){
    gmap.center = new LatLng(
        position.coords.latitude, 
        position.coords.longitude);
    
    line.path.push(gmap.center);
  }
  
  
  handleError(e){
    error = e.toString();
  }
  
  void clear(){
    line.path.clear();
  }
  
  void initMap(){
    gmap = new GMap(
        canvasMap, 
          new MapOptions()
            ..zoom = 4
            ..center = new LatLng(0, 0)
            ..mapTypeId = MapTypeId.ROADMAP
          );
    
    line = new Polyline(
        new PolylineOptions ()
          ..map = gmap
          ..strokeColor='#0022ee'
          ..geodesic=true
          ..strokeOpacity=0.7
          ..strokeWeight=2
          ..visible=true);
  }
  
}