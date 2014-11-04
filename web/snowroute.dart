import 'dart:html';
import 'dart:async';
import 'package:google_maps/google_maps.dart';

void main() {
  Positioning positioning = new Positioning();
  PositioningView view = new PositioningView();
  PositioningControl control = new PositioningControl(positioning, view);
}

class PositioningControl {
  final Positioning positioning;
  final PositioningView view;
  final buttonStart = querySelector('#buttonStart');
  final buttonStop = querySelector('#buttonStop');
  final buttonPause = querySelector('#buttonPause');
  final Stopwatch chrono = new Stopwatch();
  final Duration duration = new Duration(seconds: 1);
  
  PositioningControl(this.positioning, this.view){
    window.navigator.geolocation.watchPosition()
      .listen(
          (Geoposition position) {addPosition(position);},
          onError: (error) => view.handleError(error));
    
    view.log("Finding gps");
    buttonStart.onClick.listen((_) => start());
    buttonStop.onClick.listen((_) => stop());
    buttonPause.onClick.listen((_) => pause());

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
      Timer timer = new Timer.periodic(duration, drawTime);

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
    if (positioning.addPosition(position) && chrono.isRunning){
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
  final info = new InfoWindow();
  
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
  
  bool isError = false;
  
  PositioningView(){
    status.text = "?";
    line.map = map;
    line.path.push(new LatLng(10, 10));
    line.path.push(new LatLng(11, 11));
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

