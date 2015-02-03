library routehandler;

import 'server_rest.dart';
import 'persistence.dart';
import 'package:snowroute/route.dart';

class RouteHandler extends  EndpointHandler{
  
  final String basePath;
  
  RouteHandler(this.basePath): super("routes");
  
  @override 
  String handlePostRel(String received, RelativeEndpoint relEp){
    if (relEp.id == null){
      throw new ArgumentError.notNull("$relEp");
    }
    Route route = new Route.deserialize(received);
    if (route.id == relEp.id){
      getPersistence(relEp).update(route);
      return "updated <- $route";
    }else{
      throw new ArgumentError.value("Route Ids don't match: ${relEp.id} != ${route.id}");
    }
  }
  
  @override 
  String handlePutRel(String received, RelativeEndpoint relEp){
    if (relEp.id == null){
      throw new ArgumentError.notNull("$relEp");
    }
    Route route = new Route.deserialize(received);
    if (route.id == relEp.id){
      getPersistence(relEp).create(route);
      return "created <- $route";
    }else{
      throw new ArgumentError.value("Route Ids don't match: ${relEp.id} != ${route.id}");
    }

  }
  
  @override
  String handleGetRel(RelativeEndpoint relEp){
    if (relEp.id == null){
      return getPersistence(relEp).list.toString();
    }else{
      return getPersistence(relEp).get(relEp.id).serialize();
    }
  }
  
  @override 
  String handleDeleteRel(RelativeEndpoint relEp){
    if (relEp.id == null){
      throw new ArgumentError.notNull("$relEp");
    }
    getPersistence(relEp).delete(relEp.id);
    return "deleted $relEp";
  }
  
  RoutePersistence getPersistence(RelativeEndpoint relEndPoint){
    return new RoutePersistence("$basePath/${relEndPoint.parent.id}");
  }
}

