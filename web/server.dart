import 'dart:io';
import 'dart:async' show Future;
import 'dart:convert' show UTF8;

/* 
 * Provides CORS headers, so can be accessed from any other page
 */


abstract class EndpointHandler {
  String endpoint;
  
  EndpointHandler(this.endpoint);
  
  String handlePut(String received){
    return "Not implemented PUT for endpoint ${this.endpoint}";
  }
  String handlePost(String received){
    return "Not implemented POST for endpoint ${this.endpoint} <- $received";
  }
  String handleGet(Iterable<String> pathElements){
    return "Not implemented GET for endpoint ${this.endpoint}/${pathElements}";
  }
  String handleDelete(String id){
    return "Not implemented DELETE for endpoint ${this.endpoint}";
  }
}

class RouteHandler extends  EndpointHandler{
  
  RouteHandler(): super("route");
  
  @override 
  String handlePost(String received){
    return received;
  }
  
  @override 
  String handlePut(String received){
    return received;  
  }
  
  @override 
  String handleGet(Iterable<String> pathElements){
    return pathElements.toString();
  }
  
  @override 
  String handleDelete(String id){
    return id;
  }
}

class UserHandler extends  EndpointHandler{
  
  UserHandler(): super("user");
 
}

class RestServer{
  final String host;
  final int port;
  final Map<String, EndpointHandler> endpointHandlers= new Map<String, EndpointHandler>();
  HttpServer server;
  
  RestServer(this.host, this.port);
  
  listen(){
    HttpServer.bind(this.host, this.port).then((server) { 
      this.server = server;
      
      server.listen((HttpRequest request) {
        print("${request.method}: ${request.uri.path}");
        addCorsHeaders(request.response);

        switch (request.method) {
          case "GET": 
            _handleGet(request);
            break;
          case "POST": 
            _handlePost(request);
            break;
          case "PUT": 
            _handlePut(request);
            break;
          case "DELETE": 
            _handleDelete(request);
            break;
          /*TODO research about uses of options
           *  case "OPTIONS": 
           * handleOptions(request);
           * break;*/
          default: errorPageHandler(request);
        }
      }, 
      onError: onStartError);
      
      print("Listening for GET, PUT, POST, DELETE on $this");
    
    },
    onError: onStartError);  
  }
  
  onStartError(error){
    print("Cannot initialize the server $this <- $error");
  }
  
  void registerEndpoint(EndpointHandler endpointHandler ){
    endpointHandlers[endpointHandler.endpoint] = endpointHandler;
  }
  
  EndpointHandler _getEndpointHandler(HttpRequest req){
    if (req.uri.pathSegments.isEmpty){
      return null;
    } else {
      return this.endpointHandlers[req.uri.pathSegments.first];
    }
  }
  
  void _handleGet(HttpRequest req) {
    EndpointHandler handler = _getEndpointHandler(req);
    if (handler == null){
      errorPageHandler(req);
    } else {
      String jsonResp = handler.handleGet(req.uri.pathSegments.getRange(1,req.uri.pathSegments.length));
      _responseJson(jsonResp, req.response);

    }
  }
  
  void _handleDelete(HttpRequest req) {
    EndpointHandler handler = _getEndpointHandler(req);
    if (handler == null){
      errorPageHandler(req);
    } else {
      String jsonResp = handler.handleDelete(getId(req.uri.pathSegments));
      _responseJson(jsonResp, req.response);
    }
  }
  
  void _handlePost(HttpRequest req) {
    EndpointHandler handler = _getEndpointHandler(req);
    if (handler == null){
      errorPageHandler(req);
    } else {
      _handleInputContent(handler.handlePost, req);
    }
  }
  
  void _handlePut(HttpRequest req) {
    EndpointHandler handler = _getEndpointHandler(req);
    if (handler == null){
      errorPageHandler(req);
    } else {
      _handleInputContent(handler.handlePut, req);
    }
  }
  
  String getId(List<String> pathSegments){
    if (pathSegments.length < 2){
      return null;
    }else{
      return pathSegments[2];
    }
  }
  
  void _handleInputContent (var handler, HttpRequest req){
    UTF8.decodeStream(req).
          then( (str)=>_responseJson(handler(str), req.response)).
          catchError((error) => errorPageHandler(req));
  }
  
  void errorPageHandler(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.NOT_FOUND
      ..write('Not found ${request.uri.path}')
      ..close();
  }
  
  void _responseJson(String json, HttpResponse response){
    response.headers.add(HttpHeaders.CONTENT_TYPE, "application/json");
    if (json == null || json.isEmpty){
      response.statusCode = HttpStatus.NO_CONTENT;
    }else{
      response.statusCode = HttpStatus.OK;
      response.write(json);
    }
    response.close();
  }
  
  /**
   * Add Cross-site headers to enable accessing this server from pages
   * not served by this server
   * 
   * See: http://www.html5rocks.com/en/tutorials/cors/ 
   * and http://enable-cors.org/server.html
   */
  void addCorsHeaders(HttpResponse res) {
    res.headers.add("Access-Control-Allow-Origin", "*, ");
    res.headers.add("Access-Control-Allow-Methods", "POST, GET, PUT, DELETE, OPTIONS");
    res.headers.add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  }
  
  @override
  String toString(){
    return "http://${host}:${port}/${endpointHandlers.keys}";
  }
}

final HOST = "127.0.0.1"; // eg: localhost 
final PORT = 8080; 

void main() {
  RestServer server = new RestServer(HOST, PORT);
  
  server.registerEndpoint(new RouteHandler());
  server.registerEndpoint(new UserHandler());
  
  server.listen();
}
