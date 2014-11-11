library position;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'positioning.dart';

@CustomTag('positioning-li-element')
class PositioningLiElement extends LIElement with Polymer, ChangeNotifier {
  
  @reflectable @published Positioning get positioning => __$positioning; Positioning __$positioning; @reflectable set positioning(Positioning value) { __$positioning = notifyPropertyChange(#positioning, __$positioning, value); }
  
  factory PositioningLiElement() => new Element.tag('li', 'td-item');
  PositioningLiElement.created() : super.created() { polymerCreated(); }
  
  void delete(Event event, var detail, var target) {
    fire('delete', detail: {'key': positioning.key });
  }
}