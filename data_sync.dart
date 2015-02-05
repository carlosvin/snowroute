library datasync;
import 'package:firebase/firebase.dart';
import 'package:snowroute/route.dart';

final String  URL = "https://fiery-torch-9606.firebaseio.com/";  
final String  USER = "carlos";  

class FirebaseConnector {
  final Firebase firebaseRef;
  
  FirebaseConnector.fromUrl(String url, String user) : this.firebaseRef = _fbInstance(url,user);

  // TODO remove when multi-user is ready
  FirebaseConnector() : this.fromUrl(URL, USER);

  static  Firebase _fbInstance(String url, String user){
    return new Firebase(url).child("snowroute").child("users").child(user).child("routes");
  }
  
  void save(Route r){
    firebaseRef.child(r.id).update(r.toMap()); 
  }
  
  void register(onAdd, onUpdate, onDelete){
    firebaseRef.onChildAdded.listen((e)=> onAdd(_create(e)));
    firebaseRef.onChildChanged.listen((e)=> onUpdate(_create(e)));
    firebaseRef.onChildRemoved.listen((e)=> onDelete(_create(e)));
  }
  
  void delete(String key){
    firebaseRef.child(key).remove();
  }
  
  Route _create(Event e){
    return new Route.fromMap(e.snapshot.val());
  }

}

  
