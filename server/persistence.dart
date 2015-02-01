
library persistence;

import 'dart:io';
import 'dart:async';
import '../core/user.dart';

class Persistence {
  
  final String basePath;
  Directory baseDir;
  Persistence(this.basePath){
    baseDir = new Directory(basePath);
    if (!baseDir.existsSync()){
      baseDir.createSync(recursive: true);
    }
  }
  
  void createUser(User user){
    Directory userDir = getDirectory(user.name);
    if (userDir.existsSync()){
      throw new StateError("Cannot create an user that already exists");
    }else{
      userDir.createSync(recursive: true);
      new File("${userDir.path}/info").writeAsString(user.serialize());
    }
  }
  
  void updateUser(User user){
    Directory userDir = getDirectory(user.name);
    if (userDir.existsSync()){
      getFile(user.name).writeAsString(user.serialize());
    }else{
      throw new StateError("Cannot update an $user that doesn't exist");
    }
  }
  
  void deleteUser(String userName){
    getDirectory(userName).deleteSync(recursive: true);
  }
  
  User getUser(String name){
    return new User.deserialize(getFile(name).readAsStringSync());
  }
  
  Directory getDirectory(String name){
    return new Directory("${baseDir.path}/$name");
  }
  
  File getFile(String name){
    return new File("${getDirectory(name).path}/info");
  }
  
  
  // TODO by the moment not used
  /*Future<File> create(User user){
    Directory userDir = getDirectory(user);
    if (userDir.existsSync()){
      throw new StateError("Cannot create an user that already exists");
    }else{
      return userDir.create(recursive: true).then(
          (directory){
            return new File("${directory.path}/info").writeAsString(user.serialize());
          }
      ); 
    }
  }*/
  
  
}