import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

/// A rendering server for TeXView. This is backed by a [LocalhostServer] and a [WebViewControllerPlusPlus].
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

class TeXRenderingController {
  final WebViewControllerPlus webViewControllerPlus = WebViewControllerPlus();
  final String baseUrl =
      "http://localhost:${TeXRenderingServer.port!}/packages/flutter_tex/core/flutter_tex.html";

  RenderingControllerCallback? onPageFinishedCallback,
      onTapCallback,
      onTeXViewRenderedCallback;

  Future<WebViewControllerPlus> initController() {
    var controllerCompleter = Completer<WebViewControllerPlus>();

    webViewControllerPlus
      ..addJavaScriptChannel(
        'OnTapCallback',
        onMessageReceived: (onTapCallbackMessage) =>
            onTapCallback?.call(onTapCallbackMessage.message),
      )
      ..addJavaScriptChannel(
        'OnTeXViewRenderedCallback',
        onMessageReceived: (teXViewRenderedCallbackMessage) =>
            onTeXViewRenderedCallback
                ?.call(teXViewRenderedCallbackMessage.message),
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _debugPrint("Page finished loading: $url");
            onPageFinishedCallback?.call(url);
            controllerCompleter.complete(webViewControllerPlus);
          },
          onNavigationRequest: (request) {
            if (request.url.contains(
              baseUrl,
            )) {
              return NavigationDecision.navigate;
            } else {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..setOnConsoleMessage(
        (message) {
          _debugPrint(message.message);
        },
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
        baseUrl,
      ));

    if (!Platform.isMacOS) {
      webViewControllerPlus.setBackgroundColor(Colors.transparent);
    }

    return controllerCompleter.future;
  }

  static void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static void _debugPrint(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}

typedef RenderingControllerCallback = void Function(dynamic message);
