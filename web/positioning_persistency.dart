library persistency;

import 'dart:html';
import 'positioning.dart';
import 'package:jsonx/jsonx.dart';
import 'package:observe/observe.dart';

class PositioningPersistency extends Observable{
  
  @observable
  Storage localStorage = window.localStorage;
  
  bool add(Positioning pos) {
    if (pos.isEmpty){
      return false;
    }else{
      String key = new DateTime.fromMillisecondsSinceEpoch(pos.first.timestamp).toString();
      localStorage[key] = encode(pos);
      return true;
    }
  }
 
  @observable
  get keys => localStorage.keys;
 
}