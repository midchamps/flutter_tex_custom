import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_view/utils/core_utils.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeXViewState extends State<TeXView> {
  final WebViewControllerPlus _webViewControllerPlus =
      TeXRenderingServer.webViewControllerPlus;
  final StreamController<double> heightStreamController = StreamController();

  double _teXViewHeight = initialHeight;
  String _lastRawData = "";

  @override
  void initState() {
    TeXRenderingServer.onTapCallback =
        (tapCallbackMessage) => widget.child.onTapCallback(tapCallbackMessage);

    TeXRenderingServer.onTeXViewRenderedCallback = (h) async {
      heightStreamController
          .add(double.parse(h.toString()) + widget.heightOffset);

      // var h = await _webViewControllerPlus.webViewHeight;
      // if (_teXViewHeight != height && mounted) {
      //   setState(() {
      //     _teXViewHeight = height;
      //   });
      //   widget.onRenderFinished?.call(_teXViewHeight);
      // }
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
                controller: _webViewControllerPlus,
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

  void _renderTeXView() async {
    var currentRawData = getRawData(widget);
    if (currentRawData != _lastRawData) {
      if (widget.loadingWidgetBuilder != null) _teXViewHeight = initialHeight;
      await _webViewControllerPlus
          .runJavaScript("initTeXView($currentRawData);");
      _lastRawData = currentRawData;
    }
  }
}
