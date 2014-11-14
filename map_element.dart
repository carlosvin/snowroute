library map;

import 'package:polymer/polymer.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:html';

@CustomTag('map-element')
class MapElementP extends PolymerElement {

  GMap gmap;
  Polyline line;
  Element canvasMap;
    
  MapElementP.created() : super.created();

  @override
  void attached() {
    super.attached();
    canvasMap = $['canvas_map'];
    canvasMap.hidden = true;
  }
  
  void addPosition(num lat, num long){
    if (gmap == null){
      initMap();
    }
    _drawMap(lat, long);
  }
  
  void _drawMap(num lat, num long){
    gmap.center = new LatLng(lat, long);
    line.path.push(gmap.center);
  }
  
  void clear(){
    line.path.clear();
  }
  
  void initMap(){
    //canvasMap.style.minHeight = "100px";
    //canvasMap.style.height = "100px";
    canvasMap.hidden = false;
    gmap = new GMap(
        canvasMap, 
          new MapOptions()
            ..zoom = 18
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