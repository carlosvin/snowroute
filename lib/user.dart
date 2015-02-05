library user;


import 'interfaces.dart';
import 'route.dart';

class User extends Identifiable{
  String name;
  String pass;
  final Map<num, Route> routes = new Map();
  
  User(this.name, this.pass);
  
  User.deserialize(String userStr){
    List<String> values = userStr.split(',');
    this.name = values[0];
    this.pass = values[1];
  }
  
  String serialize (){
    return "$name,$pass";
  }
  
  @override
  String toString(){
    return name;
  }
  
  @override
  String get id => name;
  
  Map toMap(){
    Map map = new Map();
    map['name'] = name;
    map['pass'] = pass;
    //map['routes'] = routes.values.map((Route r) => r.toMap());
    return map;
  }  
  
}