import 'dart:html';
import 'package:google_maps/google_maps.dart';

void main() {
  Positioning positioning = new Positioning();
  PositioningView view = new PositioningView();
  PositioningControl control = new PositioningControl(positioning, view);
}

class PositioningControl {
  final Positioning positioning;
  final PositioningView view;
  
  PositioningControl(this.positioning, this.view){
    window.navigator.geolocation.watchPosition()
      .listen(
          (Geoposition position) {addPosition(position);}, 
          onError: (error) => view.handleError(error));
        
  }
  
  void addPosition(Geoposition position){
    view.log("enter");

    if (positioning.addPosition(position)){
      view.update(positioning);
      view.log("Updates");
    }
    else{
      view.log("No updates");
    }
  }
  
}

class Positioning { 
  
  final Map<DateTime, Geoposition> positions= new Map<DateTime, Geoposition> ();
  
  bool addPosition(Geoposition position){
    if (positions.isEmpty || positions.values.last.coords != position.coords){
      positions[new DateTime.now()] = position;
      return true;
    }else{
      return false;
    }
  }
}

class PositioningView {
  final status = querySelector("#status");
  final mapCanvas = querySelector("#mapcanvas");
  final logElement = querySelector("#log");
  final mapOptions = new MapOptions()
      ..zoom = 8
      ..center = new LatLng(0, 0)
      ..mapTypeId = MapTypeId.ROADMAP;
  final InfoWindow info = new InfoWindow()
    ..content = "you";

  GMap map;
  bool isError = false;
  
  PositioningView(){
    status.text = "?";
    map = new GMap(mapCanvas, mapOptions);
    
  }
  
  void update(Positioning positioning){
    if (isError){
      isError = false;
      status.classes.remove('error');
    }
    
    status.text= "OK";
    drawMap(positioning);
  }
  
  void drawMap(Positioning positioning){
    map.center = new LatLng(
        positioning.positions.values.last.coords.latitude, 
        positioning.positions.values.last.coords.longitude);
    info.position = map.center;
    var speed = positioning.positions.values.last.coords.speed;
    info.content = "$speed km/h";
    info.open(map);
    
  }
  
  void handleError(PositionError error){
    if (!isError){
      status.classes.add('error');
      isError = true;
    }
    status.text = error.message;   
  }
  
  void log(String message){
    logElement.text = message;
  }
}
