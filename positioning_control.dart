import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'stopwatch_element.dart';
import 'tracking_element.dart';
import 'history_element.dart';


@CustomTag('positioning-control')
class PositioningControl extends PolymerElement with ChangeNotifier  {

  @reflectable @observable String get message => __$message; String __$message = ''; @reflectable set message(String value) { __$message = notifyPropertyChange(#message, __$message, value); }
  @reflectable @observable StopwatchElement get stopwatchElement => __$stopwatchElement; StopwatchElement __$stopwatchElement; @reflectable set stopwatchElement(StopwatchElement value) { __$stopwatchElement = notifyPropertyChange(#stopwatchElement, __$stopwatchElement, value); }
  @reflectable @observable TrackingElement get trackingElement => __$trackingElement; TrackingElement __$trackingElement; @reflectable set trackingElement(TrackingElement value) { __$trackingElement = notifyPropertyChange(#trackingElement, __$trackingElement, value); }
  @reflectable @observable HistoryElement get historyElement => __$historyElement; HistoryElement __$historyElement; @reflectable set historyElement(HistoryElement value) { __$historyElement = notifyPropertyChange(#historyElement, __$historyElement, value); }

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