import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'stopwatch_element.dart';
import 'tracking_element.dart';
import 'history_element.dart';


@CustomTag('positioning-control')
class PositioningControl extends PolymerElement {

  @observable String message = '';
  @observable StopwatchElement stopwatchElement;
  @observable TrackingElement trackingElement;
  @observable HistoryElement historyElement;

  PositioningControl.created() : super.created(){
  }

  @override
  void attached() {
    super.attached();
    historyElement = $['history_element'];
    stopwatchElement = $['watch_element'];
    trackingElement= $['tracking_element'];
    
  }
  
  @ObserveProperty('stopwatchElement.state')
  stopWatchStateChanged(oldValue, newValue) {
    if (stopwatchElement.state == 0){
      message = 'stopped';
      if (oldValue != null){
        save();  
      }
    } else if (stopwatchElement.state == 1){
      message = 'started';
    } else if (stopwatchElement.state == 2){
      message = 'paused';
    } else {
      message = 'unknown state $oldValue $newValue';
    }
  }
  
  void save(){
    if ( historyElement.add(trackingElement.positioning)){
      log("Saved ${trackingElement.positioning.first.timestamp}");
    }else{
      log("Error saving");
    }
  }
  
  void log(String m){
    message = m;  
  }
}