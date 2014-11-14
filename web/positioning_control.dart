import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_toast.dart';
import 'package:paper_elements/paper_icon_button.dart';
import 'stopwatch_element.dart';
import 'tracking_element.dart';
import 'history_element.dart';
import 'map_element.dart';


@CustomTag('positioning-control')
class PositioningControl extends PolymerElement {

  @observable String state = '';
  @observable StopwatchElement stopwatchElement;
  @observable TrackingElement trackingElement;
  @observable HistoryElement historyElement;
  @observable MapElementP mapElement;
  PaperToast toastElement;
  PaperIconButton buttonToggleHistory;
  
  PositioningControl.created() : super.created(){
  }

  @override
  void attached() {
    super.attached();
    stopwatchElement = $['watch_element'];
    trackingElement= $['tracking_element'];
    historyElement = $['history_element'];
    mapElement = $['map_element'];
    toastElement= $['toast'];
    buttonToggleHistory = $['buttonToggleHistory'];
    
    historyElement.hidden = true;
    
    trackingElement.init(mapElement);
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
    
    trackingElement.clear();
  }
  
  void toast(String m){
    toastElement.text = m;
    toastElement.show();
  }
  
  void toggleHistory(){
    
    if (historyElement.isEmpty &&  historyElement.hidden ){
      toast("There are no history");
    } else{
      historyElement.hidden = ! historyElement.hidden;
          
      if (historyElement.hidden){
        buttonToggleHistory.icon = "menu";
      }else{
        buttonToggleHistory.icon = "chevron-left";
      }
    }
    
  }
}