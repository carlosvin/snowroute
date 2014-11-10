library persistency;

import 'dart:html';
import 'positioning.dart';
import 'package:jsonx/jsonx.dart';
import 'package:observe/observe.dart';

class PositioningPersistency extends ChangeNotifier{
  
  @reflectable @observable
  Storage get localStorage => __$localStorage; Storage __$localStorage = window.localStorage; @reflectable set localStorage(Storage value) { __$localStorage = notifyPropertyChange(#localStorage, __$localStorage, value); }
  
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