library routehandler;

import 'server_rest.dart';
import 'persistence.dart';

class RouteHandler extends  EndpointHandler{
  
  final Persistence persistence;
  
  RouteHandler(this.persistence): super("routes");
  
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

