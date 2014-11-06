import 'dart:html';

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