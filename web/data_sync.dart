library datasync;
import 'package:firebase/firebase.dart';

final String  URL = "https://fiery-torch-9606.firebaseio.com/";  

class FirebaseConnector {
  final Firebase firebaseRef;
  
  FirebaseConnector.fromUrl(String url) : this.firebaseRef = new Firebase(url);
  FirebaseConnector() : this.firebaseRef = new Firebase(URL);
  
  
  void save(obj){
    firebaseRef.set(obj);
  }
  
  /*void read (){
    firebaseRef.child("location/city").onValue((Event e) => e.snapshot);
  }*/
}

  
