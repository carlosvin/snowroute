library history;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'positioning_persistency.dart';

@CustomTag('history-element')
class HistoryElement extends PolymerElement {
  
  @observable PositioningPersistency persistency = new PositioningPersistency();
    
  HistoryElement.created() : super.created(){
    persistency.open();
  }


}