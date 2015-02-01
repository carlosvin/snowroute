library user;

class User{
  String name;
  String pass;
  
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
}