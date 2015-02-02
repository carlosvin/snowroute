
import 'server_rest.dart';
import 'user_handler.dart';
import 'route_handler.dart';
import 'persistence.dart';

final HOST = "127.0.0.1"; // eg: localhost 
final PORT = 8080; 

void main() {
  RestServer server = new RestServer(HOST, PORT);
  UserPersistence persistenceUser = new UserPersistence("data");
  UserHandler userHandler = new UserHandler(persistenceUser);
  userHandler.register(new RouteHandler(persistenceUser.basePath));
  server.registerEndpoint(userHandler);
  
  server.listen();
}
