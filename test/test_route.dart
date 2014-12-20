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
}

