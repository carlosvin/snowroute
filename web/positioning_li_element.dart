library position;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import '../core/route.dart';

@CustomTag('positioning-li-element')
class PositioningLiElement extends LIElement with Polymer, Observable {
  
  @published Route route;
  
  factory PositioningLiElement() => new Element.tag('li', 'td-item');
  PositioningLiElement.created() : super.created() { polymerCreated(); }
  
  void delete(Event event, var detail, var target) {
    fire('delete', detail: {'key': route.key });
  }
}