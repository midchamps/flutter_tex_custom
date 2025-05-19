import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_controller.dart';
import 'package:flutter_tex/src/tex_view/utils/core_utils.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeXViewState extends State<TeXView> {
  late final TeXRenderingController teXRenderingController;

  final StreamController<double> heightStreamController = StreamController();

  bool _isControllerReady = false;
  double _teXViewHeight = initialHeight;
  String _lastRawData = "";

  @override
  void initState() {
    if (TeXRenderingServer.multiTeXView) {
      teXRenderingController = TeXRenderingController();
      teXRenderingController.initWebViewControllerPlus();
      teXRenderingController.onPageFinishedCallback =
          (pageFinishedCallbackMessage) {
        _onControllerReady();
      };
    } else {
      teXRenderingController = TeXRenderingServer.teXRenderingController;
      _onControllerReady();
    }

    teXRenderingController.onTapCallback =
        (tapCallbackMessage) => widget.child.onTapCallback(tapCallbackMessage);

    teXRenderingController.onTeXViewRenderedCallback = (h) async {
      double height = double.parse(h.toString()) + widget.heightOffset;
      heightStreamController.add(height);
      widget.onRenderFinished?.call(height);
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _renderTeXView();
    return StreamBuilder<double>(
        stream: heightStreamController.stream,
        builder: (context, snap) {
          if (snap.hasData && !snap.hasError) {
            double height = snap.data ?? _teXViewHeight;
            return SizedBox(
              height: height,
              child: WebViewWidget(
                controller: teXRenderingController.webViewControllerPlus,
              ),
            );
          } else {
            return widget.loadingWidgetBuilder?.call(context) ??
                const SizedBox.shrink();
          }
        });
  }

  @override
  void dispose() {
    if (mounted) {
      heightStreamController.close();
    }
    super.dispose();
  }

  void _onControllerReady() {
    _isControllerReady = true;
    _renderTeXView();
  }

  void _renderTeXView() async {
    var currentRawData = getRawData(widget);
    if (currentRawData != _lastRawData && _isControllerReady) {
      if (widget.loadingWidgetBuilder != null) _teXViewHeight = initialHeight;
      await teXRenderingController.webViewControllerPlus
          .runJavaScript("initTeXView($currentRawData);");
      _lastRawData = currentRawData;
    }
  }
}
