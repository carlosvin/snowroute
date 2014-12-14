library positioning_test;

import 'package:unittest/unittest.dart';
import '../web/positioning.dart';


void main() {

  group('Position', () {
    test("Initial state", () {
      int now = new DateTime.now().millisecondsSinceEpoch;
      Position pos1 = new Position(0.0, 0.0, now);
      Position pos2 = new Position(0.1, 0.1, now + 1000);
      Position pos3 = new Position(1.0, 1.0, now + 10000);
      
      expect( pos1.getDistanceTo(pos2).round(), 16);
      expect( pos1.getDistanceTo(pos3).round(), 157);
      expect( pos2.getDistanceTo(pos3).round(), 142);

    });
       
  });
  
  group('Positioning', () {
    Positioning positioning;
    setUp(() {
      positioning = new Positioning();
    });
    tearDown(() {
      positioning = null;
    });
    test("Initial state", () {
      expect(positioning.totalDistance, 0);
      expect(positioning.duration, 0);
      expect(positioning.durationH, 0);
      expect(positioning.isEmpty, true);
      expect(positioning.speedAvg, 0);
      //expect(positioning.last, throwsStateError);
    });
    
    test("First position", () {
      positioning.addPosition(0.0, 0.0, new DateTime.now().millisecondsSinceEpoch);
      expect(positioning.totalDistance, 0);
      expect(positioning.duration, 0);
      expect(positioning.durationH, 0);
      expect(positioning.isEmpty, false);
      expect(positioning.speedAvg, 0);
      //expect(positioning.last, throwsStateError);
    });
    
    test("2 positions", () {
      int now = new DateTime.now().millisecondsSinceEpoch;
      positioning.addPosition(0.0, 0.0, now);
      positioning.addPosition(0.1, 0.1, now + 1000);
     
    });
  });
}

