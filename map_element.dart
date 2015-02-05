library map;

import 'package:polymer/polymer.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:html';
import 'package:snowroute/interfaces.dart';

@CustomTag('map-element')
class MapElementView extends PolymerElement implements TrackingListener{

  bool isInit = false;
  GMap gmap;
  Polyline line;
  Element canvasMap;
  Marker endMarker;
  MapElementView.created() : super.created();

  @override
  void attached() {
    super.attached();
    canvasMap = $['canvas_map'];
    canvasMap.hidden = true;
  }
  
  @override
  void stopTracking(){
    isInit = false;
  }
  
  @override
  void newPosition(num lat, num long, bool tracking){
    LatLng pos = new LatLng(lat, long);
    if (!isInit){
      _initMap(pos);
    }
    _drawMap(pos, tracking);
  }
  
  void _drawMap(LatLng pos, bool tracking){
    gmap.panTo(pos);
    //gmap.center = ;
    endMarker.position = pos;
    if (tracking){
      line.path.push(pos);
    }
  }

  void _initMap(LatLng pos){
    
    if (!isInstantiated){
      _instatiate(pos);
    }
    
    line.path.clear();
    
    final marker = new Marker(new MarkerOptions()
      ..position = pos
      ..map = gmap
      ..title = 'Initial position'
    );
    
    isInit = true;

  }
  
  void _instatiate(LatLng pos){
    canvasMap.hidden = false;

    gmap = new GMap(
        canvasMap, 
          new MapOptions()
            ..zoom = 18
            ..center = pos
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
    
    endMarker = new Marker(new MarkerOptions()
    ..position = pos
    ..map = gmap
    ..title = 'Last position');
  }
  
  bool get isInstantiated => gmap != null;
}