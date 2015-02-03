library server_persistence;

import "package:snowroute/persistence.dart";
import "package:snowroute/user.dart";
import "package:snowroute/route.dart";

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