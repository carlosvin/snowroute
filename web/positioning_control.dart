import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_icon_button.dart';
import 'stopwatch_element.dart';
import 'data_sync.dart';
import 'tracking_element.dart';
import 'history_element.dart';
import 'map_element.dart';
import 'toast_levels_element.dart';
import 'package:snowroute/interfaces.dart';

@CustomTag('positioning-control')
class PositioningControl extends PolymerElement implements StateListener{

  @observable String state = '';
  @observable StopwatchElement stopwatchElement;
  @observable TrackingElement trackingElement;
  @observable HistoryElement historyElement;
  @observable MapElementView mapElement;
  
  ToastLevelsElement toastElement;
  PaperIconButton buttonToggleHistory;
  
  final FirebaseConnector firebaseconnector = new FirebaseConnector();
  
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
    
    trackingElement.init(mapElement, toastElement,firebaseconnector);
    historyElement.init(USER, firebaseconnector);
    
    stopwatchElement.register(this);
    stopwatchElement.register(trackingElement);
    
  }
  
  @override
  void onStateStopped(){
    state = 'stopped';
  }
  
  @override
  void onStateStarted(){
    state = 'started';
  }
  
  @override
  void onStatePaused(){
    state = 'paused';
  }
  
  void toggleHistory(){
    if (historyElement.isEmpty){
      toastElement.warn("There are no history");
    }else{
      historyElement.hidden = ! historyElement.hidden;
      
      if (historyElement.hidden){
        buttonToggleHistory.icon = "menu";
      }else{
        buttonToggleHistory.icon = "chevron-left";
      }
    }
  }
}