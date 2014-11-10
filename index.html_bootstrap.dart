library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'package:core_elements/core_meta.dart' as i0;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_iconset.dart' as i1;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_icon.dart' as i2;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_iconset_svg.dart' as i3;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_icon_button.dart' as i4;
import 'package:polymer/src/build/log_injector.dart';
import 'stopwatch_element.dart' as i5;
import 'package:polymer/src/build/log_injector.dart';
import 'tracking_element.dart' as i6;
import 'package:polymer/src/build/log_injector.dart';
import 'history_element.dart' as i7;
import 'package:polymer/src/build/log_injector.dart';
import 'positioning_control.dart' as i8;
import 'package:polymer/src/build/log_injector.dart';
import 'index.html.0.dart' as i9;
import 'package:polymer/src/build/log_injector.dart';
import 'package:smoke/smoke.dart' show Declaration, PROPERTY, METHOD;
import 'package:smoke/static.dart' show useGeneratedCode, StaticConfiguration;
import 'stopwatch_element.dart' as smoke_0;
import 'package:polymer/polymer.dart' as smoke_1;
import 'package:observe/src/metadata.dart' as smoke_2;
import 'tracking_element.dart' as smoke_3;
import 'history_element.dart' as smoke_4;
import 'positioning_control.dart' as smoke_5;
abstract class _M0 {} // PolymerElement & ChangeNotifier

void main() {
  useGeneratedCode(new StaticConfiguration(
      checkedMode: false,
      getters: {
        #counter: (o) => o.counter,
        #delete: (o) => o.delete,
        #gpsStatus: (o) => o.gpsStatus,
        #historyElement: (o) => o.historyElement,
        #icon: (o) => o.icon,
        #k: (o) => o.k,
        #keys: (o) => o.keys,
        #message: (o) => o.message,
        #pause: (o) => o.pause,
        #speedAverage: (o) => o.speedAverage,
        #src: (o) => o.src,
        #start: (o) => o.start,
        #state: (o) => o.state,
        #stop: (o) => o.stop,
        #stopWatchStateChanged: (o) => o.stopWatchStateChanged,
        #stopwatchElement: (o) => o.stopwatchElement,
        #trackingElement: (o) => o.trackingElement,
      },
      setters: {
        #counter: (o, v) { o.counter = v; },
        #gpsStatus: (o, v) { o.gpsStatus = v; },
        #historyElement: (o, v) { o.historyElement = v; },
        #icon: (o, v) { o.icon = v; },
        #k: (o, v) { o.k = v; },
        #message: (o, v) { o.message = v; },
        #speedAverage: (o, v) { o.speedAverage = v; },
        #src: (o, v) { o.src = v; },
        #state: (o, v) { o.state = v; },
        #stopwatchElement: (o, v) { o.stopwatchElement = v; },
        #trackingElement: (o, v) { o.trackingElement = v; },
      },
      parents: {
        smoke_4.HistoryElement: smoke_1.PolymerElement,
        smoke_5.PositioningControl: _M0,
        smoke_0.StopwatchElement: _M0,
        smoke_3.TrackingElement: _M0,
        _M0: smoke_1.PolymerElement,
      },
      declarations: {
        smoke_4.HistoryElement: {
          #keys: const Declaration(#keys, List, isFinal: true, annotations: const [smoke_2.observable]),
        },
        smoke_5.PositioningControl: {
          #historyElement: const Declaration(#historyElement, smoke_4.HistoryElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #message: const Declaration(#message, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #stopWatchStateChanged: const Declaration(#stopWatchStateChanged, Function, kind: METHOD, annotations: const [const smoke_1.ObserveProperty('stopwatchElement.state')]),
          #stopwatchElement: const Declaration(#stopwatchElement, smoke_0.StopwatchElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #trackingElement: const Declaration(#trackingElement, smoke_3.TrackingElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_0.StopwatchElement: {
          #counter: const Declaration(#counter, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #state: const Declaration(#state, num, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_3.TrackingElement: {
          #gpsStatus: const Declaration(#gpsStatus, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #speedAverage: const Declaration(#speedAverage, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
      },
      names: {
        #counter: r'counter',
        #delete: r'delete',
        #gpsStatus: r'gpsStatus',
        #historyElement: r'historyElement',
        #icon: r'icon',
        #k: r'k',
        #keys: r'keys',
        #message: r'message',
        #pause: r'pause',
        #speedAverage: r'speedAverage',
        #src: r'src',
        #start: r'start',
        #state: r'state',
        #stop: r'stop',
        #stopWatchStateChanged: r'stopWatchStateChanged',
        #stopwatchElement: r'stopwatchElement',
        #trackingElement: r'trackingElement',
      }));
  new LogInjector().injectLogsFromUrl('index.html._buildLogs');
  configureForDeployment([
      i0.upgradeCoreMeta,
      i1.upgradeCoreIconset,
      i2.upgradeCoreIcon,
      i3.upgradeCoreIconsetSvg,
      i4.upgradeCoreIconButton,
      () => Polymer.register('stopwatch-element', i5.StopwatchElement),
      () => Polymer.register('tracking-element', i6.TrackingElement),
      () => Polymer.register('history-element', i7.HistoryElement),
      () => Polymer.register('positioning-control', i8.PositioningControl),
    ]);
  i9.main();
}
