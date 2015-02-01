library userhandler;

import 'server_rest.dart';
import '../core/user.dart';
import 'persistence.dart';

class UserHandler extends EndpointHandler{
  
  final Persistence persistence;
  
  UserHandler(this.persistence): super("users");
  
  @override 
   String handlePostRel(String received, RelativeEndpoint relEp){
     if (relEp.id == null){
       throw new ArgumentError.notNull("$relEp");
     }
     User user = new User.deserialize(received);
     
     persistence.updateUser(user);
     
     return "Updated $user";  
   }
   
   @override 
   String handlePutRel(String received, RelativeEndpoint relEp){
      if (relEp.id == null){
        throw new ArgumentError.notNull("$relEp");
      }
      User user = new User.deserialize(received);
      if (user.name == relEp.id){
        persistence.createUser(user);
        return "Created $user";   
      }else{
        throw new StateError("${user.name} != ${relEp.id}"); 
      }
   }
   
   @override 
   String handleGetRel(RelativeEndpoint relEp){
     if (relEp.id == null){
        return "list";
     }else{
        return persistence.getUser(relEp.id).serialize();
     }
   }
   
   @override 
   String handleDeleteRel(RelativeEndpoint relEp){
     if (relEp.id == null){
       throw new ArgumentError.notNull("$relEp");
     }
     persistence.deleteUser(relEp.id);
     return "deleted $relEp";
   }
}