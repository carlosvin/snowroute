library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'package:core_elements/core_meta.dart' as i0;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_iconset.dart' as i1;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_icon.dart' as i2;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_focusable.dart' as i3;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_button_base.dart' as i4;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_ripple.dart' as i5;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_shadow.dart' as i6;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_fab.dart' as i7;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_iconset_svg.dart' as i8;
import 'package:polymer/src/build/log_injector.dart';
import 'stopwatch_element.dart' as i9;
import 'package:polymer/src/build/log_injector.dart';
import 'tracking_element.dart' as i10;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_icon_button.dart' as i11;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_icon_button.dart' as i12;
import 'package:polymer/src/build/log_injector.dart';
import 'positioning_li_element.dart' as i13;
import 'package:polymer/src/build/log_injector.dart';
import 'history_element.dart' as i14;
import 'package:polymer/src/build/log_injector.dart';
import 'map_element.dart' as i15;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_transition.dart' as i16;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_key_helper.dart' as i17;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_overlay_layer.dart' as i18;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_overlay.dart' as i19;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_transition_css.dart' as i20;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_media_query.dart' as i21;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_toast.dart' as i22;
import 'package:polymer/src/build/log_injector.dart';
import 'toast_levels_element.dart' as i23;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_toolbar.dart' as i24;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_header_panel.dart' as i25;
import 'package:polymer/src/build/log_injector.dart';
import 'positioning_control.dart' as i26;
import 'package:polymer/src/build/log_injector.dart';
import 'index.html.0.dart' as i27;
import 'package:polymer/src/build/log_injector.dart';
import 'package:smoke/smoke.dart' show Declaration, PROPERTY, METHOD;
import 'package:smoke/static.dart' show useGeneratedCode, StaticConfiguration;
import 'stopwatch_element.dart' as smoke_0;
import 'package:polymer/polymer.dart' as smoke_1;
import 'package:observe/src/metadata.dart' as smoke_2;
import 'tracking_element.dart' as smoke_3;
import 'positioning_li_element.dart' as smoke_4;
import 'route.dart' as smoke_5;
import 'history_element.dart' as smoke_6;
import 'map_element.dart' as smoke_7;
import 'toast_levels_element.dart' as smoke_8;
import 'positioning_control.dart' as smoke_9;
abstract class _M0 {} // PolymerElement & StateNotifier
abstract class _M1 {} // _M0 & ChangeNotifier
abstract class _M2 {} // PolymerElement & StateListener
abstract class _M3 {} // _M2 & ChangeNotifier
abstract class _M5 {} // _M4 & ChangeNotifier
abstract class _M6 {} // PolymerElement & ChangeNotifier
abstract class _M4 {} // Object & Polymer

void main() {
  useGeneratedCode(new StaticConfiguration(
      checkedMode: false,
      getters: {
        #borderColor: (o) => o.borderColor,
        #counter: (o) => o.counter,
        #delete: (o) => o.delete,
        #duration: (o) => o.duration,
        #historyElement: (o) => o.historyElement,
        #mapElement: (o) => o.mapElement,
        #onDelete: (o) => o.onDelete,
        #pause: (o) => o.pause,
        #positioning: (o) => o.positioning,
        #practices: (o) => o.practices,
        #route: (o) => o.route,
        #speedAverage: (o) => o.speedAverage,
        #speedAvg: (o) => o.speedAvg,
        #start: (o) => o.start,
        #state: (o) => o.state,
        #stop: (o) => o.stop,
        #stopwatchElement: (o) => o.stopwatchElement,
        #toggleHistory: (o) => o.toggleHistory,
        #totalDistance: (o) => o.totalDistance,
        #trackingElement: (o) => o.trackingElement,
        #values: (o) => o.values,
      },
      setters: {
        #borderColor: (o, v) { o.borderColor = v; },
        #counter: (o, v) { o.counter = v; },
        #historyElement: (o, v) { o.historyElement = v; },
        #mapElement: (o, v) { o.mapElement = v; },
        #positioning: (o, v) { o.positioning = v; },
        #route: (o, v) { o.route = v; },
        #speedAverage: (o, v) { o.speedAverage = v; },
        #state: (o, v) { o.state = v; },
        #stopwatchElement: (o, v) { o.stopwatchElement = v; },
        #totalDistance: (o, v) { o.totalDistance = v; },
        #trackingElement: (o, v) { o.trackingElement = v; },
      },
      parents: {
        smoke_6.HistoryElement: smoke_1.PolymerElement,
        smoke_7.MapElementView: smoke_1.PolymerElement,
        smoke_9.PositioningControl: _M6,
        smoke_4.PositioningLiElement: _M5,
        smoke_0.StopwatchElement: _M1,
        smoke_8.ToastLevelsElement: smoke_1.PolymerElement,
        smoke_3.TrackingElement: _M3,
        _M0: smoke_1.PolymerElement,
        _M1: _M0,
        _M2: smoke_1.PolymerElement,
        _M3: _M2,
        _M5: _M4,
        _M6: smoke_1.PolymerElement,
      },
      declarations: {
        smoke_6.HistoryElement: {
          #practices: const Declaration(#practices, Map, isFinal: true, annotations: const [smoke_2.observable]),
        },
        smoke_7.MapElementView: {},
        smoke_9.PositioningControl: {
          #historyElement: const Declaration(#historyElement, smoke_6.HistoryElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #mapElement: const Declaration(#mapElement, smoke_7.MapElementView, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #state: const Declaration(#state, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #stopwatchElement: const Declaration(#stopwatchElement, smoke_0.StopwatchElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #trackingElement: const Declaration(#trackingElement, smoke_3.TrackingElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_4.PositioningLiElement: {
          #route: const Declaration(#route, smoke_5.Route, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
        smoke_0.StopwatchElement: {
          #counter: const Declaration(#counter, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_8.ToastLevelsElement: {},
        smoke_3.TrackingElement: {
          #borderColor: const Declaration(#borderColor, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #speedAverage: const Declaration(#speedAverage, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #totalDistance: const Declaration(#totalDistance, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
      },
      names: {
        #borderColor: r'borderColor',
        #counter: r'counter',
        #delete: r'delete',
        #duration: r'duration',
        #historyElement: r'historyElement',
        #mapElement: r'mapElement',
        #onDelete: r'onDelete',
        #pause: r'pause',
        #positioning: r'positioning',
        #practices: r'practices',
        #route: r'route',
        #speedAverage: r'speedAverage',
        #speedAvg: r'speedAvg',
        #start: r'start',
        #state: r'state',
        #stop: r'stop',
        #stopwatchElement: r'stopwatchElement',
        #toggleHistory: r'toggleHistory',
        #totalDistance: r'totalDistance',
        #trackingElement: r'trackingElement',
        #values: r'values',
      }));
  new LogInjector().injectLogsFromUrl('index.html._buildLogs');
  configureForDeployment([
      i0.upgradeCoreMeta,
      i1.upgradeCoreIconset,
      i2.upgradeCoreIcon,
      i4.upgradePaperButtonBase,
      i5.upgradePaperRipple,
      i6.upgradePaperShadow,
      i7.upgradePaperFab,
      i8.upgradeCoreIconsetSvg,
      () => Polymer.register('stopwatch-element', i9.StopwatchElement),
      () => Polymer.register('tracking-element', i10.TrackingElement),
      i11.upgradeCoreIconButton,
      i12.upgradePaperIconButton,
      () => Polymer.register('positioning-li-element', i13.PositioningLiElement),
      () => Polymer.register('history-element', i14.HistoryElement),
      () => Polymer.register('map-element', i15.MapElementView),
      i16.upgradeCoreTransition,
      i17.upgradeCoreKeyHelper,
      i18.upgradeCoreOverlayLayer,
      i19.upgradeCoreOverlay,
      i20.upgradeCoreTransitionCss,
      i21.upgradeCoreMediaQuery,
      i22.upgradePaperToast,
      () => Polymer.register('toast-levels-element', i23.ToastLevelsElement),
      i24.upgradeCoreToolbar,
      i25.upgradeCoreHeaderPanel,
      () => Polymer.register('positioning-control', i26.PositioningControl),
    ]);
  i27.main();
}
