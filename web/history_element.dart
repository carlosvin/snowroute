library history;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'package:jsonx/jsonx.dart';
import 'dart:html';
import 'positioning.dart';

@CustomTag('history-element')
class HistoryElement extends PolymerElement {
  
  Storage localStorage;
  
  @observable final List<String> keys =  toObservable([]);
  
  HistoryElement.created() : super.created(){
  }
  
  @override
  void attached() {
   super.attached();
   localStorage = window.localStorage;
   keys.addAll(localStorage.keys);
  }

  bool add(Positioning pos) {
    if (pos.isEmpty){
      return false;
    }else{
      String key = new DateTime.fromMillisecondsSinceEpoch(pos.first.timestamp).toString();
      localStorage[key] = encode(pos);
      keys.add(key);
      return true;
    }
  }
}