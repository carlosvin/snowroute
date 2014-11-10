library persistency;

import 'dart:html';
import 'positioning.dart';
import 'dart:indexed_db' as idb;
import 'dart:async';

class PositioningPersistency {
  
  static final String DB = "positioning";
  static final String STORE = "positions";
  
  final Set<int> keys = new Set<int>();
  idb.Database _db;
  int _version = 1;
  
  Future open() {
    return window.indexedDB.open(DB, version: _version,
    onUpgradeNeeded: _onUpgradeNeeded)
    .then(_onOpened);
  }
  
  void _onUpgradeNeeded(idb.VersionChangeEvent e) {
    idb.Database db = (e.target as idb.OpenDBRequest).result;
    if (!db.objectStoreNames.contains(STORE)) {
      db.createObjectStore(STORE, keyPath: 'timeStamp');
    }
  }  
  
  void _onOpened(idb.Database db) {
    _db = db;
    _loadFromDB();
  }
  
  Future<Positioning> add(Positioning pos) {
    if (pos.isEmpty){
      return new Future.error('Position is empty');
    }else{
      var positionAsMap = pos.toRaw();
      var transaction = _db.transaction(STORE, 'readwrite');
      var objectStore = transaction.objectStore(STORE);
      return objectStore.add(positionAsMap);
    }
 }
 
 Future _loadFromDB() {
    if (_db == null){
      return new Future.value(0);
    }
    else{
      var trans = _db.transaction(STORE, 'readonly');
      var store = trans.objectStore(STORE);
      
      // Get everything in the store.
      var cursors = store.openCursor(autoAdvance: true).asBroadcastStream();
      cursors.listen((cursor) {
        keys.add(cursor.key);
      });
      return cursors.length.then((_) {
        return keys.length;
      });
    }
  }
}