
import 'restServer.dart';

class RouteHandler extends  EndpointHandler{
  
  RouteHandler(): super("routes");
  
  @override 
  String handlePostRel(String received, RelativeEndpoint relEp){
    if (relEp.id == null){
      throw new ArgumentError.notNull("$relEp");
    }
    return "$relEp <- $received";  
  }
  
  @override 
  String handlePutRel(String received, RelativeEndpoint relEp){
    if (relEp.id == null){
      throw new ArgumentError.notNull("$relEp");
    }
    return "$relEp <- $received";  
  }
  
  @override
  String handleGetRel(RelativeEndpoint relEp){
    if (relEp.id == null){
      return "list";
    }else{
      return "getting ${relEp}";
    }
  }
  
  @override 
  String handleDeleteRel(RelativeEndpoint relEp){
    if (relEp.id == null){
      throw new ArgumentError.notNull("$relEp");
    }
    return "deleting $relEp";
  }
}

class UserHandler extends EndpointHandler{
  
  UserHandler(): super("users");
  
  @override 
   String handlePostRel(String received, RelativeEndpoint relEp){
     if (relEp.id == null){
       throw new ArgumentError.notNull("$relEp");
     }
     return "$relEp <- $received";  
   }
   
   @override 
   String handlePutRel(String received, RelativeEndpoint relEp){
     if (relEp.id == null){
       throw new ArgumentError.notNull("$relEp");
     }
     return "$relEp <- $received";  
   }
   
   @override 
   String handleGetRel(RelativeEndpoint relEp){
     if (relEp.id == null){
       return "list";
     }else{
       return "getting ${relEp}";
     }
   }
   
   @override 
   String handleDeleteRel(RelativeEndpoint relEp){
     if (relEp.id == null){
       throw new ArgumentError.notNull("$relEp");
     }
     return "deleting $relEp";
   }
}


final HOST = "127.0.0.1"; // eg: localhost 
final PORT = 8080; 

void main() {
  RestServer server = new RestServer(HOST, PORT);
  
  UserHandler userHandler = new UserHandler();
  userHandler.register(new RouteHandler());
  server.registerEndpoint(userHandler);
  
  server.listen();
}
