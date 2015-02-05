library history;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'package:snowroute/route.dart';
import 'data_sync.dart';
import 'dart:html';

@CustomTag('history-element')
class HistoryElement extends PolymerElement {
  
  
  @observable final Map<String,Route> routes =  toObservable({});
  
  FirebaseConnector _db;
  
  HistoryElement.created() : super.created();
  
  void init(String user, FirebaseConnector db){
    this._db = db;
    this._db.register(_onAdd, _onAdd, _onDelete);
  }

  void _onAdd(Route route) {
    routes[route.id] = route;
  }
  
  void _onDelete(Route route) {
    routes.remove(route.id);
  }
  
  void onDelete(Event event, var detail, var target){
    _db.delete(detail['route'].id);
  }
  
  bool get isEmpty => routes.isEmpty;
}