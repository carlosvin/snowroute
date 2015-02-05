library route_test;

import 'package:unittest/unittest.dart';
import 'package:snowroute/user.dart';

void main() {

  group('User', () {
    test("Initial state", () {
      User user1 = new User("carlos", "secret");
      String serializedUser = user1.serialize();
      User user2 = new User.deserialize(serializedUser);
      expect( user1.name, user2.name);
      expect( user1.pass, user2.pass);
      
      print(user1.serialize());
    });
       
  });
  
}

