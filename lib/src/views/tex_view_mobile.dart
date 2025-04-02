import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeXViewState extends State<TeXView> with AutomaticKeepAliveClientMixin {
  final WebViewControllerPlus _controller =
      TeXRenderingServer.webViewControllerPlus;

  double _height = initialHeight;
  String _lastRawData = "";

  @override
  void initState() {
    TeXRenderingServer.onTeXViewRenderedCallback =
        (teXViewRenderedCallbackMessage) {
      double newHeight = double.parse(teXViewRenderedCallbackMessage);

      if (_height != newHeight && mounted) {
        setState(() {
          _height = newHeight;
        });
        widget.onRenderFinished?.call(_height);
      }
    };

    TeXRenderingServer.onTapCallback =
        (tapCallbackMessage) => widget.child.onTapCallback(tapCallbackMessage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateKeepAlive();
    _renderTeXView();
    return IndexedStack(
      index: widget.loadingWidgetBuilder?.call(context) != null
          ? _height == initialHeight
              ? 1
              : 0
          : 0,
      children: <Widget>[
        SizedBox(
          height: _height,
          child: WebViewWidget(
            controller: _controller,
          ),
        ),
        widget.loadingWidgetBuilder?.call(context) ?? const SizedBox.shrink()
      ],
    );
  }

  void _renderTeXView() async {
    var currentRawData = getRawData(widget);
    if (currentRawData != _lastRawData) {
      if (widget.loadingWidgetBuilder != null) _height = initialHeight;
      await _controller.runJavaScript("initView($currentRawData);");
      _lastRawData = currentRawData;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
