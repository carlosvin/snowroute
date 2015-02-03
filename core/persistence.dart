
library persistence;

import 'dart:io';
import 'interfaces.dart';

abstract class  Persistence<I extends Identifiable> {
  
  final String basePath;
  Directory baseDir;
  Persistence(this.basePath){
    baseDir = new Directory(basePath);
    if (!baseDir.existsSync()){
      baseDir.createSync(recursive: true);
    }
  }
  
  void create(I identifiable){
    Directory dir = getDirectory(identifiable.id);
    if (dir.existsSync()){
      throw new StateError("Cannot create an object that already exists");
    }else{
      dir.createSync(recursive: true);
      new File("${dir.path}/info").writeAsString(identifiable.serialize());
    }
  }
  
  void update(I identifiable){
    Directory dir = getDirectory(identifiable.id);
    if (dir.existsSync()){
      getFile(identifiable.id).writeAsString(identifiable.serialize());
    }else{
      throw new StateError("Cannot update an $identifiable that doesn't exist");
    }
  }
  
  void delete(String id){
    getDirectory(id).deleteSync(recursive: true);
  }
  
  I get(String id){
    return deserialize(getFile(id).readAsStringSync());
  }
  
  Directory getDirectory(String name){
    return new Directory("${baseDir.path}/$name");
  }
  
  File getFile(String name){
    return new File("${getDirectory(name).path}/info");
  }
  
  List<String> get list {
    List<String> subDirs = new List<String> ();
    for (FileSystemEntity fse in baseDir.listSync(recursive: false, followLinks: true)){
      if (fse.statSync().type == FileSystemEntityType.DIRECTORY){
        subDirs.add(fse.path.replaceFirst("${fse.parent.path}/", ""));
      }
    }
    return subDirs;
  }
  
  I deserialize(String str);
  
  
  
}