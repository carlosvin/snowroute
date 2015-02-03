library history;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:snowroute/route.dart';

@CustomTag('history-element')
class HistoryElement extends PolymerElement {
  
  Storage localStorage;
  
  @observable final Map<String,Route> practices =  toObservable({});
  
  HistoryElement.created() : super.created(){
  }
  
  @override
  void attached() {
   super.attached();
   localStorage = window.localStorage;
   for (var v in localStorage.values){
     try{
      add(new Route.deserialize(v), false);
     }catch(e){
      print("ignoring $v");       
     }
   }
   print ("${practices.length} Practices read");
  }

  bool add(Route route, [persist = true]) {
    if (route == null){
      return false;
    }else{
      practices[route.key] = route;
      if (persist){
        localStorage[route.key] = route.serialize();  
      }
      return true;
    }
  }
  
  void onDelete(Event event, var detail, var target) {
    String key = detail['key'];
    localStorage.remove(key);
    practices.remove(key);
  }
  
  bool get isEmpty => practices.isEmpty;
}