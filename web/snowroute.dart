import 'dart:html';
import 'dart:async';
import 'package:google_maps/google_maps.dart';
import 'package:polymer/polymer.dart';

//void main() {
//  initPolymer().run(() {
//    // Code that doesn't need to wait.
//    Polymer.onReady.then((_) {
//      Positioning positioning = new Positioning();
//      PositioningView view = new PositioningView();
//      PositioningControl control = new PositioningControl(positioning, view);
//    });
//  });
//}

class PositioningControl {
  final Positioning positioning;
  final PositioningView view;
  final buttonStart = querySelector('#buttonStart');
  final buttonStop = querySelector('#buttonStop');
  final buttonPause = querySelector('#buttonPause');
  final Stopwatch chrono = new Stopwatch();
  final Duration duration = new Duration(seconds: 1);
  Timer timer;
  
  PositioningControl(this.positioning, this.view){
    view.log("Finding gps");
    buttonStart.onClick.listen((_) => start());
    buttonStop.onClick.listen((_) => stop());
    buttonPause.onClick.listen((_) => pause());
    window.navigator.geolocation.watchPosition(enableHighAccuracy: true)
          .listen(
              (Geoposition position) {addPosition(position);},
              onError: (error) => view.handleError(error));
        
  }
  
  void start(){
    if (chrono.isRunning){
      view.log("Already running");
    }else{
      if (!positioning.isEmpty()){
        final last = positioning.last();
        positioning.clear();
      }
      chrono.start();
      timer = new Timer.periodic(duration, drawTime);

    }
  }
  
  void stop(){
    if (chrono.isRunning){
      chrono.stop();
    }
  }
  
  void pause(){
    chrono.stop();
  }
  
  void drawTime(Timer t){
    view.duration(chrono.elapsed);
    if (!chrono.isRunning){
      t.cancel();
    }
  }
  
  void addPosition(Geoposition position){
    if (positioning.addPosition(position)){
      view.update(positioning);
      view.log("Moving");
    }
    else{
      view.log("Are you stopped?");
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
  
  Geoposition last(){
    return positions.values.last;
  }
  
  bool isEmpty(){
    return positions.isEmpty;  
  }
  
  void clear(){
    positions.clear();
  }
}

class PositioningView {
  final status = querySelector("#status");
  final logElement = querySelector("#log");
  final chrono = querySelector("#chrono");
  
  final line = new Polyline(
      new PolylineOptions ()
        ..strokeColor='#0022ee'
        ..geodesic=true
        ..strokeOpacity=0.7
        ..strokeWeight=2
        ..visible=true);

  final map = new GMap(
      querySelector("#mapcanvas"), 
      new MapOptions()
        ..zoom = 10
        ..center = new LatLng(0, 0)
        ..mapTypeId = MapTypeId.ROADMAP
      );
  final info = new InfoWindow();

  bool isError = false;
  
  PositioningView(){
    status.text = "?";
    line.map = map;
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
    line.path.push(map.center);
    
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
  
  void duration(Duration d){
    chrono.text = d.toString();
  }
}

