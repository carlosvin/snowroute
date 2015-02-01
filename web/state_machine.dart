library state;

import '../core/interfaces.dart';


abstract class StateNotifier {
  
  final Set<StateListener> listeners = new Set<StateListener>();
  bool _isStarted = false, _isStopped = false, _isPaused = false;
  
  void register(StateListener listener){
    listeners.add(listener);
  }
  
  void deregister(StateListener listener){
    listeners.remove(listener);
  }
  
  void notifyStart(){
    _isStarted = true;
    _isPaused = false;
    _isStopped = false;
    listeners.forEach((StateListener l) => l.onStateStarted());
  }

  void notifyStop(){
    _isStarted = false;
    _isPaused = false;
    _isStopped = true;
    listeners.forEach((StateListener l) => l.onStateStopped());
  }
  
  void notifyPause(){
    _isStarted = false;
    _isPaused = true;
    _isStopped = false;
    listeners.forEach((StateListener l) => l.onStatePaused());
  }
  
  get isStarted => _isStarted;
  get isStopped => _isStopped;
  get isPaused => _isPaused;
}
