library userhandler;

import 'server_rest.dart';
import '../core/user.dart';
import '../core/persistence.dart';

class UserHandler extends EndpointHandler{
  
  final Persistence<User> persistence;
  
  UserHandler(this.persistence): super("users");
  
  @override 
   String handlePostRel(String received, RelativeEndpoint relEp){
     if (relEp.id == null){
       throw new ArgumentError.notNull("$relEp");
     }
     User user = new User.deserialize(received);
     
     persistence.update(user);
     
     return "Updated $user";  
   }
   
   @override 
   String handlePutRel(String received, RelativeEndpoint relEp){
      if (relEp.id == null){
        throw new ArgumentError.notNull("$relEp");
      }
      User user = new User.deserialize(received);
      if (user.name == relEp.id){
        persistence.create(user);
        return "Created $user";   
      }else{
        throw new StateError("${user.name} != ${relEp.id}"); 
      }
   }
   
   @override 
   String handleGetRel(RelativeEndpoint relEp){
     if (relEp.id == null){
        return persistence.list.toString();
     }else{
        return persistence.get(relEp.id).serialize();
     }
   }
   
   @override 
   String handleDeleteRel(RelativeEndpoint relEp){
     if (relEp.id == null){
       throw new ArgumentError.notNull("$relEp");
     }
     persistence.delete(relEp.id);
     return "deleted $relEp";
   }
}