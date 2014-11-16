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
import 'map_element.dart' as i15;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_toolbar.dart' as i16;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_header_panel.dart' as i17;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_transition.dart' as i18;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_key_helper.dart' as i19;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_overlay_layer.dart' as i20;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_overlay.dart' as i21;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_transition_css.dart' as i22;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_media_query.dart' as i23;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_toast.dart' as i24;
import 'package:polymer/src/build/log_injector.dart';
import 'positioning_control.dart' as i25;
import 'package:polymer/src/build/log_injector.dart';
import 'index.html.0.dart' as i26;
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
import 'map_element.dart' as smoke_7;
import 'positioning_control.dart' as smoke_8;
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
        #$: (o) => o.$,
        #blurAction: (o) => o.blurAction,
        #borderColor: (o) => o.borderColor,
        #container: (o) => o.container,
        #contextMenuAction: (o) => o.contextMenuAction,
        #counter: (o) => o.counter,
        #delete: (o) => o.delete,
        #dismiss: (o) => o.dismiss,
        #downAction: (o) => o.downAction,
        #duration: (o) => o.duration,
        #focusAction: (o) => o.focusAction,
        #gpsStatus: (o) => o.gpsStatus,
        #historyElement: (o) => o.historyElement,
        #icon: (o) => o.icon,
        #iconSrc: (o) => o.iconSrc,
        #label: (o) => o.label,
        #mapElement: (o) => o.mapElement,
        #mode: (o) => o.mode,
        #narrowMode: (o) => o.narrowMode,
        #onDelete: (o) => o.onDelete,
        #opened: (o) => o.opened,
        #pause: (o) => o.pause,
        #positioning: (o) => o.positioning,
        #practices: (o) => o.practices,
        #raisedButton: (o) => o.raisedButton,
        #responsiveWidth: (o) => o.responsiveWidth,
        #speedAverage: (o) => o.speedAverage,
        #speedAvg: (o) => o.speedAvg,
        #src: (o) => o.src,
        #start: (o) => o.start,
        #state: (o) => o.state,
        #stop: (o) => o.stop,
        #stopwatchElement: (o) => o.stopwatchElement,
        #text: (o) => o.text,
        #toggleHistory: (o) => o.toggleHistory,
        #totalDistance: (o) => o.totalDistance,
        #trackingElement: (o) => o.trackingElement,
        #upAction: (o) => o.upAction,
        #values: (o) => o.values,
        #z: (o) => o.z,
      },
      setters: {
        #borderColor: (o, v) { o.borderColor = v; },
        #container: (o, v) { o.container = v; },
        #counter: (o, v) { o.counter = v; },
        #gpsStatus: (o, v) { o.gpsStatus = v; },
        #historyElement: (o, v) { o.historyElement = v; },
        #icon: (o, v) { o.icon = v; },
        #iconSrc: (o, v) { o.iconSrc = v; },
        #mapElement: (o, v) { o.mapElement = v; },
        #narrowMode: (o, v) { o.narrowMode = v; },
        #opened: (o, v) { o.opened = v; },
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
        smoke_7.MapElementP: smoke_1.PolymerElement,
        smoke_8.PositioningControl: _M6,
        smoke_4.PositioningLiElement: _M5,
        smoke_0.StopwatchElement: _M1,
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
        smoke_7.MapElementP: {},
        smoke_8.PositioningControl: {
          #historyElement: const Declaration(#historyElement, smoke_6.HistoryElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #mapElement: const Declaration(#mapElement, smoke_7.MapElementP, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #state: const Declaration(#state, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #stopwatchElement: const Declaration(#stopwatchElement, smoke_0.StopwatchElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #trackingElement: const Declaration(#trackingElement, smoke_3.TrackingElement, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_4.PositioningLiElement: {
          #positioning: const Declaration(#positioning, smoke_5.Positioning, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
        smoke_0.StopwatchElement: {
          #counter: const Declaration(#counter, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_3.TrackingElement: {
          #borderColor: const Declaration(#borderColor, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #gpsStatus: const Declaration(#gpsStatus, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #speedAverage: const Declaration(#speedAverage, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
      },
      names: {
        #$: r'$',
        #blurAction: r'blurAction',
        #borderColor: r'borderColor',
        #container: r'container',
        #contextMenuAction: r'contextMenuAction',
        #counter: r'counter',
        #delete: r'delete',
        #dismiss: r'dismiss',
        #downAction: r'downAction',
        #duration: r'duration',
        #focusAction: r'focusAction',
        #gpsStatus: r'gpsStatus',
        #historyElement: r'historyElement',
        #icon: r'icon',
        #iconSrc: r'iconSrc',
        #label: r'label',
        #mapElement: r'mapElement',
        #mode: r'mode',
        #narrowMode: r'narrowMode',
        #onDelete: r'onDelete',
        #opened: r'opened',
        #pause: r'pause',
        #positioning: r'positioning',
        #practices: r'practices',
        #raisedButton: r'raisedButton',
        #responsiveWidth: r'responsiveWidth',
        #speedAverage: r'speedAverage',
        #speedAvg: r'speedAvg',
        #src: r'src',
        #start: r'start',
        #state: r'state',
        #stop: r'stop',
        #stopwatchElement: r'stopwatchElement',
        #text: r'text',
        #toggleHistory: r'toggleHistory',
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
      () => Polymer.register('map-element', i15.MapElementP),
      i16.upgradeCoreToolbar,
      i17.upgradeCoreHeaderPanel,
      i18.upgradeCoreTransition,
      i19.upgradeCoreKeyHelper,
      i20.upgradeCoreOverlayLayer,
      i21.upgradeCoreOverlay,
      i22.upgradeCoreTransitionCss,
      i23.upgradeCoreMediaQuery,
      i24.upgradePaperToast,
      () => Polymer.register('positioning-control', i25.PositioningControl),
    ]);
  i26.main();
}
