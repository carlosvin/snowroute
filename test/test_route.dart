library route_test;

import 'package:unittest/unittest.dart';
import '../web/route.dart';
import 'dart:io';

void main() {

  group('Position', () {
    test("Initial state", () {
      DateTime now = new DateTime.now();
      Duration oneH = new Duration(hours: 1);
      
      Pos pos1 = new Pos(0.0, 0.0, now, null);
      Pos pos2 = new Pos(0.1, 0.1, now.add(oneH), pos1);
      Pos pos3 = new Pos(1.0, 1.0, now.add(oneH), pos2);
      
      expect( pos1.distancePrev, 0);
      expect( pos1.distanceNext.round(), 15725);
      expect( pos2.distancePrev.round(), 15725);
      expect( pos2.distanceNext.round(), 141524);
      expect( pos3.distancePrev.round(), 141524);
      expect( pos3.distanceNext, null);

    });
       
  });
  group('Route', () {
    Route route;
    setUp(() {
      route = new Route.fromCoords(0.0, 0.0);
    });
    tearDown(() {
      route = null;
    });
    
    test("Initial state", () {
      expect(route.distance, 0);
      expect(route.duration, new Duration(milliseconds: 0));
      expect(route.speedAvg.isNaN, true);
    });

    
    test("Several positions", () {
      Duration twoS = new Duration(seconds: 2);
      Duration oneS = new Duration(seconds: 1);
      
      sleep(twoS);
      route.add(0.01, 0.01); // 1573m
      expect(route.distance.round(), 1573);
      expect(route.speedAvg.round(), 786);
      
      sleep(oneS);
      route.add(0.011, 0.011);  // 157.3m
      expect(route.distance.round(), 1573 + 157);
      expect(route.speedAvg.round(), ((1573 + 157) / 3).round());

      sleep(twoS); 
      route.add(0.01, 0.01);// 157.3m
      expect(route.distance.round(), 1887);
      expect(route.speedAvg.round(), (1887/5).round());

    });
  });
  
/* By the moment we dont need equality operators, so they are removed.
  group('Equality', () {
    Route route1, route2,routediff1,routediff2;
    setUp(() {
      route1 = new Route.fromCoords(12.12, 3.3);
      route2 = new Route.fromCoords(12.12, 3.3);
      routediff1 = new Route.fromCoords(12.12, 3.3);
      routediff2 = new Route.fromCoords(12.12, 3.3);
      for (double i=0.0; i<10; i+=1) {
        var long = i*1.1;
        route1.add(i,long);
        route2.add(i, long);
        routediff1.add(i, long + 1);
        sleep(new Duration(milliseconds: 10));
        routediff2.add(i, i*1.1);
      }
    });
    tearDown(() {
      route1 = null;
      route2 = null;
      routediff1 = null;
      routediff2 = null;
    });
  test("Equals", () {
      expect(route1, route2);
      expect(route1 == routediff1, false);
      expect(route1 == routediff2, false);
      expect(route2 == routediff1, false);
      expect(route2 == routediff2, false);
      expect(routediff1 == routediff2, false);
    });
    
    test("HashCode", () {
      expect(route1.hashCode, route2.hashCode);
      expect(route1.hashCode == routediff1.hashCode,  false);
      expect(route1.hashCode != routediff1.hashCode,  true);
      expect(route2.hashCode == routediff2.hashCode,  false);
      expect(route2.hashCode != routediff2.hashCode,  true);    });
       
  });
*/
  group('Serialization', () {
      Route route;
      setUp(() {
        route = new Route.fromCoords(-1.0, -1.0);
        for (double i=0.0; i<10; i+=1) {
          route.add(i, i*2);
          sleep(new Duration(milliseconds: 10));
        }
      });
      tearDown(() {
        route = null;
      });
      
      test("Serialize", () {
        String serializedStr = route.serialize();

        Route deserialized = new Route.deserialize(serializedStr);
        
        expect(deserialized.serialize(), serializedStr);
        
      });
         
    });
}

