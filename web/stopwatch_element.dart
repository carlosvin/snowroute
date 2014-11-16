library watch;

import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';
import 'state_machine.dart';

@CustomTag('stopwatch-element')
class StopwatchElement extends PolymerElement with StateNotifier {
  static final oneSecond = new Duration(seconds:1);
  static final initialCounterState = '00:00:00';
  
  @observable String counter=initialCounterState;
  
  StopwatchElement.created() : super.created();
  
  Stopwatch watch = new Stopwatch();
  Timer timer;
  
  Element stopButton;
  Element startButton;
  Element pauseButton;
    
  @override
  void attached() {
    super.attached();
    startButton = $['startButton'];
    stopButton = $['stopButton'];
    pauseButton = $['pauseButton'];
        
    stopButton.hidden = true;
    pauseButton.hidden = true;
  }
  
  @override
  void detached() {
    super.detached();
    timer.cancel();
  }
  
  void start(Event e, var detail, Node target) {
    watch.start();
    timer = new Timer.periodic(oneSecond, updateTime);
    startButton.hidden = true;
    stopButton.hidden = false;
    pauseButton.hidden = false;
    notifyStart();
  }
  
  void stop(Event e, var detail, Node target) {
    watch.reset();
    timer.cancel();
    startButton.hidden = false;
    pauseButton.hidden = true;
    stopButton.hidden = true;
    counter = initialCounterState;
    notifyStop();
  }
  
  void pause(Event e, var detail, Node target) {
    watch.stop();
    startButton.hidden = false;
    pauseButton.hidden = true;
    stopButton.hidden = false;
    notifyPause();
  }
  
  void updateTime(Timer _) {
    final hour = numberToDigits(watch.elapsed.inHours);
    final minute = numberToDigits(watch.elapsed.inMinutes);
    final second = numberToDigits(watch.elapsed.inSeconds);
    
    counter = '$hour:$minute:$second';
  }
  
  String numberToDigits(num n){
    if (n < 10){
      return '0$n';
    }else{
      return '$n'; 
    }
  }
}
