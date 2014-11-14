import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_toast.dart';
import 'package:paper_elements/paper_icon_button.dart';
import 'stopwatch_element.dart';
import 'tracking_element.dart';
import 'history_element.dart';
import 'map_element.dart';


@CustomTag('positioning-control')
class PositioningControl extends PolymerElement with ChangeNotifier  {

  @reflectable @observable String get state => __$state; String __$state = ''; @reflectable set state(String value) { __$state = notifyPropertyChange(#state, __$state, value); }
  @reflectable @observable StopwatchElement get stopwatchElement => __$stopwatchElement; StopwatchElement __$stopwatchElement; @reflectable set stopwatchElement(StopwatchElement value) { __$stopwatchElement = notifyPropertyChange(#stopwatchElement, __$stopwatchElement, value); }
  @reflectable @observable TrackingElement get trackingElement => __$trackingElement; TrackingElement __$trackingElement; @reflectable set trackingElement(TrackingElement value) { __$trackingElement = notifyPropertyChange(#trackingElement, __$trackingElement, value); }
  @reflectable @observable HistoryElement get historyElement => __$historyElement; HistoryElement __$historyElement; @reflectable set historyElement(HistoryElement value) { __$historyElement = notifyPropertyChange(#historyElement, __$historyElement, value); }
  @reflectable @observable MapElementP get mapElement => __$mapElement; MapElementP __$mapElement; @reflectable set mapElement(MapElementP value) { __$mapElement = notifyPropertyChange(#mapElement, __$mapElement, value); }
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