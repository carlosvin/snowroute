library server_persistence;

import "../core/persistence.dart";
import "../core/user.dart";
import "../core/route.dart";

class UserPersistence extends Persistence<User>{
  
  UserPersistence(String basePath):super(basePath);
  
  @override
  User deserialize(String s){
    return new User.deserialize(s);
  }

}

class RoutePersistence extends Persistence<Route>{
  
  RoutePersistence(String basePath):super(basePath);
  
  @override
  Route deserialize(String s){
    return new Route.deserialize(s);
  }

}