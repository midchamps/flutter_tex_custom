import 'dart:async';

import 'package:flutter_tex/src/tex_server/tex_rendering_controller.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

/// A rendering server for TeXView. This is backed by a [LocalhostServer] and a [WebViewControllerPlus].
/// Make sure to call [start] before using the [TeXRenderingServer].
class TeXRenderingServer {
  static final LocalhostServer _server = LocalhostServer();
  static final TeXRenderingController teXRenderingController =
      TeXRenderingController();

  static bool multiTeXView = false;

  static int? get port => _server.port;

  static Future<void> start({int port = 0}) async {
    await _server.start(port: port);
    await teXRenderingController.initController();
  }

  static Future<void> stop() async {
    await _server.close();
  }
}
