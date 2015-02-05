library position;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:snowroute/route.dart';

@CustomTag('positioning-li-element')
class PositioningLiElement extends LIElement with Polymer, ChangeNotifier {
  
  @reflectable @published Route get route => __$route; Route __$route; @reflectable set route(Route value) { __$route = notifyPropertyChange(#route, __$route, value); }
  
  factory PositioningLiElement() => new Element.tag('li', 'td-item');
  PositioningLiElement.created() : super.created() { polymerCreated(); }
  
  void delete(Event event, var detail, var target) {
    fire('delete', detail: {'route': route });
  }
}