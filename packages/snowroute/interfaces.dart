library interfaces;


abstract class MessageNotifier {
  
  void error(String m);
  void warn(String m);
  void info(String m);
}


abstract class StateListener {

  void onStateStarted();
  void onStateStopped();
  void onStatePaused();
}

abstract class TrackingListener {
  void newPosition(num lat, num long, bool tracking);
  void stopTracking();
}

abstract class Identifiable {
  
  String get id;
  
  String serialize();
  
  
  
}