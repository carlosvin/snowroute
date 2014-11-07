import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'stopwatch_element.dart';


@CustomTag('positioning-control')
class PositioningControl extends PolymerElement with ChangeNotifier  {
  @reflectable @observable String get message => __$message; String __$message = ''; @reflectable set message(String value) { __$message = notifyPropertyChange(#message, __$message, value); }

  @reflectable @observable StopwatchElement get stopwatchElement => __$stopwatchElement; StopwatchElement __$stopwatchElement; @reflectable set stopwatchElement(StopwatchElement value) { __$stopwatchElement = notifyPropertyChange(#stopwatchElement, __$stopwatchElement, value); }

  PositioningControl.created() : super.created();

  @override
  void attached() {
    super.attached();
    stopwatchElement = $['watch_element'];
  }
  
  @ObserveProperty('stopwatchElement.state')
  stopWatchStateChanged(oldValue, newValue) {
    if (stopwatchElement.state == 0){
      message = 'stopped';
    } else if (stopwatchElement.state == 1){
      message = 'started';
    } else if (stopwatchElement.state == 2){
      message = 'paused';
    } else {
      message = 'unknown state $oldValue $newValue';
    }
  }
  
  
}