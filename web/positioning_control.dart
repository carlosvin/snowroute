import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_toast.dart';
import 'package:paper_elements/paper_icon_button.dart';
import 'stopwatch_element.dart';
import 'tracking_element.dart';
import 'history_element.dart';
import 'map_element.dart';
import 'state_machine.dart';


@CustomTag('positioning-control')
class PositioningControl extends PolymerElement implements StateListener{

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
    
    stopwatchElement.register(this);
    stopwatchElement.register(trackingElement);
    
    trackingElement.listener = mapElement;
  }
  
  void onStateStopped(){
    state = 'stopped';
    if ( historyElement.add(trackingElement.route)){
      toast("Saved ${trackingElement.route.key}");
    }else{
      toast("Error saving");
    }
    
  }
  
  void onStateStarted(){
    state = 'started';
  }
  
  @override
  void onStatePaused(){
    state = 'paused';
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