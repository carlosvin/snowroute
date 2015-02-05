library datasync;
import 'package:firebase/firebase.dart';
import 'package:snowroute/route.dart';

final String  URL = "https://fiery-torch-9606.firebaseio.com/";  

class FirebaseConnector {
  final Firebase firebaseRef;
  Firebase usersRef;
  FirebaseConnector.fromUrl(String url) : this.firebaseRef = new Firebase(url){
    usersRef= firebaseRef.child("snowroute").child("user"); 
  }

  FirebaseConnector() : this.fromUrl(URL);
  
  void save(String user, Route r){
    getUserRoutesRoot(user).child(r.id).update(r.toMap()); 
  }
  
  void register(String user, onAdd, onUpdate, onDelete){
    getUserRoutesRoot(user).onChildAdded.listen((e)=> onAdd(_create(e)));
    getUserRoutesRoot(user).onChildChanged.listen((e)=> onUpdate(_create(e)));
    getUserRoutesRoot(user).onChildRemoved.listen((e)=> onDelete(_create(e)));
  }
  
  Firebase getUserRoutesRoot(String user){
    return usersRef.child(user).child("routes");
  }
  
  Route _create(Event e){
    return new Route.fromMap(e.snapshot.val());
  }
  
  void delete(String user, String key){
    getUserRoutesRoot(user).child(key).remove();
  }
}

  
