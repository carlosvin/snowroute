
import 'server_rest.dart';
import 'user_handler.dart';
import 'route_handler.dart';
import 'persistence.dart';


final HOST = "127.0.0.1"; // eg: localhost 
final PORT = 8080; 

void main() {
  RestServer server = new RestServer(HOST, PORT);
  Persistence persistence = new Persistence("data");
  UserHandler userHandler = new UserHandler(persistence);
  userHandler.register(new RouteHandler(persistence));
  server.registerEndpoint(userHandler);
  
  server.listen();
}
