import 'dart:io';
//import 'dart:async' show Future;
import 'dart:convert' show UTF8;


class RelativeEndpoint{
  final String id;
  final String current;
  List<String> nextPath;
  final RelativeEndpoint parent;
  
  RelativeEndpoint(this.id, Iterable<String> nextPath, this.parent, this.current){
    this.nextPath = new List.from(nextPath);
  }
  
  bool get hasNextEndpoint => nextPath != null && nextPath.isNotEmpty;
  bool get hasParent => parent != null;
  
  String get nextEndpoint {
    if (hasNextEndpoint){
      return nextPath.first;
    }else{
      return null;
    }
  }

  @override
  String toString(){
    return "$current/$id";
  }
}

abstract class EndpointHandler {
  
  final String endpoint;
  final Map<String, EndpointHandler> endpointHandlers = new Map<String, EndpointHandler>();
  
  EndpointHandler(this.endpoint);
  
  void register(EndpointHandler handler){
    endpointHandlers[handler.endpoint]= handler; 
  }

  RelativeEndpoint createRelativeEndpoint(RelativeEndpoint parentRelativeEndpoint){
    List<String> pathElements = parentRelativeEndpoint.nextPath;
    if (pathElements==null || pathElements.isEmpty){
      throw new ArgumentError("Current endpoint ($endpoint) path cannot be null");
    } else {
      if (pathElements.first == endpoint){
        if (pathElements.length > 1){
          String id = pathElements.elementAt(1);
          if (id.isEmpty){
            id = null;
          }
          return new RelativeEndpoint(id, pathElements.getRange(2,pathElements.length), parentRelativeEndpoint, endpoint);
        }else{
          return new RelativeEndpoint(null,null, parentRelativeEndpoint, endpoint);
        }
      }else{
        throw new ArgumentError("Unexpected entity (${pathElements.first}), expected ($endpoint)");
      }
    }
  }
  
  String handlePut(String received,RelativeEndpoint parentRelativeEndpoint){
    RelativeEndpoint relEp = createRelativeEndpoint(parentRelativeEndpoint);
    if (relEp.hasNextEndpoint && endpointHandlers.containsKey(relEp.nextEndpoint)){
      return endpointHandlers[relEp.nextEndpoint].handlePut(received, relEp);
    } else {
      return handlePutRel(received, relEp);
    }
  }
  
  String handlePost(String received,RelativeEndpoint parentRelativeEndpoint){
    RelativeEndpoint relEp = createRelativeEndpoint(parentRelativeEndpoint);
    if (relEp.hasNextEndpoint && endpointHandlers.containsKey(relEp.nextEndpoint)){
      return endpointHandlers[relEp.nextEndpoint].handlePost(received, relEp);
    } else {
      return handlePostRel(received, relEp);
    }
  }
  
  String handleGet(RelativeEndpoint parentRelativeEndpoint){
    RelativeEndpoint relEp = createRelativeEndpoint(parentRelativeEndpoint);
    if (relEp.hasNextEndpoint && endpointHandlers.containsKey(relEp.nextEndpoint)){
      return endpointHandlers[relEp.nextEndpoint].handleGet(relEp);
    } else {
      return handleGetRel(relEp);
    }
  }
  
  String handleDelete(RelativeEndpoint parentRelativeEndpoint){
    RelativeEndpoint relEp = createRelativeEndpoint(parentRelativeEndpoint);
    if (relEp.hasNextEndpoint && endpointHandlers.containsKey(relEp.nextEndpoint)){
      return endpointHandlers[relEp.nextEndpoint].handleDelete(relEp);
    } else {
      return handleDeleteRel(relEp);
    }
  }
  
  String handlePutRel(String received, RelativeEndpoint relEp);
  String handlePostRel(String received, RelativeEndpoint relEp);
  String handleGetRel(RelativeEndpoint relEp);
  String handleDeleteRel(RelativeEndpoint relEp);
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
        try{
          print("${request.method}: ${request.uri.path}");
          _addCorsHeaders(request.response);
          EndpointHandler handler = _getEndpointHandler(request);
          
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
            default: errorPageHandler(request);
          }
        }catch(e){
          errorPageHandlerException(request, e);            
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
      String jsonResp = handler.handleGet(new RelativeEndpoint(null, req.uri.pathSegments, null, ''));
      _responseJson(jsonResp, req.response);
    }
  }
  
  void _handleDelete(HttpRequest req) {
    EndpointHandler handler = _getEndpointHandler(req);
    if (handler == null){
      errorPageHandler(req);
    } else {
      String jsonResp = handler.handleDelete(new RelativeEndpoint(null, req.uri.pathSegments, null, ''));
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
      return pathSegments[1];
    }
  }
  
  void _handleInputContent (var handler, HttpRequest req){
    UTF8.decodeStream(req).
          then( (str)=>_responseJson(handler(str, new RelativeEndpoint(null, req.uri.pathSegments, null, '')), req.response)).
          catchError((error) => errorPageHandlerException(req, error));
  }
  
  void errorPageHandler(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.NOT_FOUND
      ..write('Not found ${request.uri.path}')
      ..close();
  }
  
  
  void errorPageHandlerException(HttpRequest request,  e) {
    request.response
      ..statusCode = HttpStatus.BAD_REQUEST
      ..writeln('${request.uri.path}')
      ..writeln('$e')
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
  void _addCorsHeaders(HttpResponse res) {
    res.headers.add("Access-Control-Allow-Origin", "*, ");
    res.headers.add("Access-Control-Allow-Methods", "POST, GET, PUT, DELETE, OPTIONS");
    res.headers.add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  }
  
  @override
  String toString(){
    return "http://${host}:${port}/${endpointHandlers.keys}";
  }
}