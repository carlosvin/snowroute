library history;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'positioning.dart';

@CustomTag('history-element')
class HistoryElement extends PolymerElement {
  
  Storage localStorage;
  
  @observable final Map<String,Positioning> practices =  toObservable({});
  
  HistoryElement.created() : super.created(){
  }
  
  @override
  void attached() {
   super.attached();
   localStorage = window.localStorage;
   for (var v in localStorage.values){
     try{
       add(new Positioning.deserialize(v), false);
     }catch(e){
        print("ignoring $v");       
     }
   }
   print ("${practices.length} Practices read");
  }

  bool add(Positioning pos, [persist = true]) {
    if (pos==null || pos.isEmpty){
      return false;
    }else{
      practices[pos.key] = pos;
      if (persist){
        localStorage[pos.key] = pos.serialize();  
      }
      return true;
    }
  }
  
  void onDelete(Event event, var detail, var target) {
    String key = detail['key'];
    localStorage.remove(key);
    practices.remove(key);
  }
}