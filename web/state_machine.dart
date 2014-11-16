library state;

abstract class StateNotifier {
  
  final Set<StateListener> listeners = new Set<StateListener>();
  
  void register(StateListener listener){
    listeners.add(listener);
  }
  
  void deregister(StateListener listener){
    listeners.remove(listener);
  }
  
  void notifyStart(){
    listeners.forEach((StateListener l) => l.onStateStarted());
  }

  void notifyStop(){
    listeners.forEach((StateListener l) => l.onStateStopped());
  }
  
  void notifyPause(){
    listeners.forEach((StateListener l) => l.onStatePaused());
  }
}

abstract class StateListener {

  void onStateStarted();
  void onStateStopped();
  void onStatePaused();
}