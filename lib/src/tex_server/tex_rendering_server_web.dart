import 'dart:js_interop';

import 'package:flutter_tex/src/tex_view/tex_view_web.dart';

@JS('OnTeXViewRenderedCallback')
external set onTeXViewRenderedCallback(JSFunction callback);

@JS('OnTapCallback')
external set onTapCallback(JSFunction callback);

class TeXRenderingServer {
  static bool multiTeXView = false;

  static Future<void> start({int port = 0}) async {
    TeXViewWebManager.initialize();
  }

  static Future<void> stop() async {
    TeXViewWebManager.dispose();
  }
}

/// Manages the global callbacks and communication between JS and Dart.
class TeXViewWebManager {
  static bool _isInitialized = false;

  /// A map to hold references to the state of each TeXView instance.
  static final Map<String, TeXViewState> _instances = {};

  /// Registers an instance of TeXViewState to be managed.
  static void registerInstance(String viewId, TeXViewState instance) {
    _instances[viewId] = instance;
  }

  /// Unregisters an instance when it's disposed.
  static void unregisterInstance(String viewId) {
    _instances.remove(viewId);
  }

  /// Initializes the global JavaScript callbacks. Should only be called once.
  static void initialize() {
    if (_isInitialized) return;

    onTeXViewRenderedCallback = _onTeXViewRendered.toJS;
    onTapCallback = _onTap.toJS;
    _isInitialized = true;
  }

  /// Disposes the global callbacks and resets the state.
  static void dispose() {
    onTeXViewRenderedCallback = (() {}).toJS;
    onTapCallback = (() {}).toJS;
    _isInitialized = false;
  }

  // Top-level or static callback handlers.
  static void _onTeXViewRendered(JSNumber h, JSString iframeId) {
    final instance = _instances[iframeId.toDart];
    if (instance != null && instance.mounted) {
      instance.onTeXViewRendered(h, iframeId);
    }
  }

  static void _onTap(JSString tapId, JSString iframeId) {
    final instance = _instances[iframeId.toDart];
    if (instance != null && instance.mounted) {
      instance.onTap(tapId, iframeId);
    }
  }
}
