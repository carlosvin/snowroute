library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'package:core_elements/core_meta.dart' as i0;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_iconset.dart' as i1;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_icon.dart' as i2;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_focusable.dart' as i3;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_ripple.dart' as i4;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_shadow.dart' as i5;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_button.dart' as i6;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_icon_button.dart' as i7;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_fab.dart' as i8;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_iconset_svg.dart' as i9;
import 'package:polymer/src/build/log_injector.dart';
import 'stopwatch_element.dart' as i10;
import 'package:polymer/src/build/log_injector.dart';
import 'tracking_element.dart' as i11;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_icon_button.dart' as i12;
import 'package:polymer/src/build/log_injector.dart';
import 'positioning_li_element.dart' as i13;
import 'package:polymer/src/build/log_injector.dart';
import 'history_element.dart' as i14;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_toolbar.dart' as i15;
import 'package:polymer/src/build/log_injector.dart';
import 'positioning_control.dart' as i16;
import 'package:polymer/src/build/log_injector.dart';
import 'index.html.0.dart' as i17;
import 'package:polymer/src/build/log_injector.dart';
import 'package:smoke/smoke.dart' show Declaration, PROPERTY, METHOD;
import 'package:smoke/static.dart' show useGeneratedCode, StaticConfiguration;
import 'stopwatch_element.dart' as smoke_0;
import 'package:polymer/polymer.dart' as smoke_1;
import 'package:observe/src/metadata.dart' as smoke_2;
import 'tracking_element.dart' as smoke_3;
import 'positioning_li_element.dart' as smoke_4;
import 'positioning.dart' as smoke_5;
import 'history_element.dart' as smoke_6;
import 'positioning_control.dart' as smoke_7;
abstract class _M0 {} // PolymerElement & ChangeNotifier
abstract class _M2 {} // _M1 & ChangeNotifier
abstract class _M1 {} // Object & Polymer

void main() {
  useGeneratedCode(new StaticConfiguration(
      checkedMode: false,
      getters: {
        #blurAction: (o) => o.blurAction,
        #contextMenuAction: (o) => o.contextMenuAction,
        #counter: (o) => o.counter,
        #delete: (o) => o.delete,
        #downAction: (o) => o.downAction,
        #duration: (o) => o.duration,
        #focusAction: (o) => o.focusAction,
        #gpsStatus: (o) => o.gpsStatus,
        #historyElement: (o) => o.historyElement,
        #icon: (o) => o.icon,
        #iconSrc: (o) => o.iconSrc,
        #label: (o) => o.label,
        #message: (o) => o.message,
        #onDelete: (o) => o.onDelete,
        #pause: (o) => o.pause,
        #positioning: (o) => o.positioning,
        #practices: (o) => o.practices,
        #raisedButton: (o) => o.raisedButton,
        #speedAverage: (o) => o.speedAverage,
        #speedAvg: (o) => o.speedAvg,
        #src: (o) => o.src,
        #start: (o) => o.start,
        #state: (o) => o.state,
        #stop: (o) => o.stop,
        #stopWatchStateChanged: (o) => o.stopWatchStateChanged,
        #stopwatchElement: (o) => o.stopwatchElement,
        #totalDistance: (o) => o.totalDistance,
        #trackingElement: (o) => o.trackingElement,
        #upAction: (o) => o.upAction,
        #values: (o) => o.values,
        #z: (o) => o.z,
      },
      setters: {
        #counter: (o, v) { o.counter = v; },
        #gpsStatus: (o, v) { o.gpsStatus = v; },
        #historyElement: (o, v) { o.historyElement = v; },
        #icon: (o, v) { o.icon = v; },
        #iconSrc: (o, v) { o.iconSrc = v; },
        #message: (o, v) { o.message = v; },
        #positioning: (o, v) { o.positioning = v; },
        #speedAverage: (o, v) { o.speedAverage = v; },
        #src: (o, v) { o.src = v; },
        #state: (o, v) { o.state = v; },
        #stopwatchElement: (o, v) { o.stopwatchElement = v; },
        #trackingElement: (o, v) { o.trackingElement = v; },
        #z: (o, v) { o.z = v; },
      },
      parents: {
        smoke_6.HistoryElement: smoke_1.PolymerElement,
        smoke_7.PositioningControl: _M0,
        smoke_4.PositioningLiElement: _M2,
        smoke_0.StopwatchElement: _M0,
        smoke_3.TrackingElement: _M0,
        _M0: smoke_1.PolymerElement,
        _M2: _M1,
      },
      declarations: {
        smoke_6.HistoryElement: {
          #practices: const Declaration(#practices, Map, isFinal: true, annotations: const [smoke_2.observable]),
        },
        smoke_7.PositioningControl: {
          #historyElement: const Declaration(#historyElement, smoke_6.HistoryElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #message: const Declaration(#message, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #stopWatchStateChanged: const Declaration(#stopWatchStateChanged, Function, kind: METHOD, annotations: const [const smoke_1.ObserveProperty('stopwatchElement.state')]),
          #stopwatchElement: const Declaration(#stopwatchElement, smoke_0.StopwatchElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #trackingElement: const Declaration(#trackingElement, smoke_3.TrackingElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_4.PositioningLiElement: {
          #positioning: const Declaration(#positioning, smoke_5.Positioning, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
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
        #blurAction: r'blurAction',
        #contextMenuAction: r'contextMenuAction',
        #counter: r'counter',
        #delete: r'delete',
        #downAction: r'downAction',
        #duration: r'duration',
        #focusAction: r'focusAction',
        #gpsStatus: r'gpsStatus',
        #historyElement: r'historyElement',
        #icon: r'icon',
        #iconSrc: r'iconSrc',
        #label: r'label',
        #message: r'message',
        #onDelete: r'onDelete',
        #pause: r'pause',
        #positioning: r'positioning',
        #practices: r'practices',
        #raisedButton: r'raisedButton',
        #speedAverage: r'speedAverage',
        #speedAvg: r'speedAvg',
        #src: r'src',
        #start: r'start',
        #state: r'state',
        #stop: r'stop',
        #stopWatchStateChanged: r'stopWatchStateChanged',
        #stopwatchElement: r'stopwatchElement',
        #totalDistance: r'totalDistance',
        #trackingElement: r'trackingElement',
        #upAction: r'upAction',
        #values: r'values',
        #z: r'z',
      }));
  new LogInjector().injectLogsFromUrl('index.html._buildLogs');
  configureForDeployment([
      i0.upgradeCoreMeta,
      i1.upgradeCoreIconset,
      i2.upgradeCoreIcon,
      i3.upgradePaperFocusable,
      i4.upgradePaperRipple,
      i5.upgradePaperShadow,
      i6.upgradePaperButton,
      i7.upgradePaperIconButton,
      i8.upgradePaperFab,
      i9.upgradeCoreIconsetSvg,
      () => Polymer.register('stopwatch-element', i10.StopwatchElement),
      () => Polymer.register('tracking-element', i11.TrackingElement),
      i12.upgradeCoreIconButton,
      () => Polymer.register('positioning-li-element', i13.PositioningLiElement),
      () => Polymer.register('history-element', i14.HistoryElement),
      i15.upgradeCoreToolbar,
      () => Polymer.register('positioning-control', i16.PositioningControl),
    ]);
  i17.main();
}
