import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_toast.dart';
import 'stopwatch_element.dart';
import 'tracking_element.dart';
import 'history_element.dart';


@CustomTag('positioning-control')
class PositioningControl extends PolymerElement {

  @observable String state = '';
  @observable StopwatchElement stopwatchElement;
  @observable TrackingElement trackingElement;
  @observable HistoryElement historyElement;
  PaperToast toastElement;

  PositioningControl.created() : super.created(){
  }

  @override
  void attached() {
    super.attached();
    historyElement = $['history_element'];
    stopwatchElement = $['watch_element'];
    trackingElement= $['tracking_element'];
    toastElement= $['toast'];
    
  }
  
  @ObserveProperty('stopwatchElement.state')
  stopWatchStateChanged(oldValue, newValue) {
    if (stopwatchElement.state == 0){
      state = 'stopped';
      if (oldValue != null){
        save();  
      }
    } else if (stopwatchElement.state == 1){
      state = 'started';
    } else if (stopwatchElement.state == 2){
      state = 'paused';
    } else {
      state = 'unknown state $oldValue $newValue';
    }
  }
  
  void save(){
    if ( historyElement.add(trackingElement.positioning)){
      toast("Saved ${trackingElement.positioning.first.timestamp}");
    }else{
      toast("Error saving");
    }
  }
  
  void toast(String m){
    toastElement.text = m;
    toastElement.show();
  }
}