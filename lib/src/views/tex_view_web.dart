import 'dart:js_interop';
import 'dart:ui_web';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'package:web/web.dart';

@JS('TeXViewRenderedCallback')
external set teXViewRenderedCallback(JSFunction callback);

@JS('OnTapCallback')
external set onTapCallback(JSFunction callback);

@JS('initWebTeXView')
external void initWebTeXView(String viewId, String rawData);

class TeXViewState extends State<TeXView> {
  String? _lastData;
  double widgetHeight = initialHeight;
  final String _viewId = UniqueKey().toString();
  bool _isReady = false;

  @override
  Widget build(BuildContext context) {
    _initTeXView();
    return SizedBox(
      height: widgetHeight,
      child: HtmlElementView(
        key: widget.key ?? ValueKey(_viewId),
        viewType: _viewId,
      ),
    );
  }

  @override
  void initState() {
    platformViewRegistry.registerViewFactory(
        _viewId,
        (int id) => HTMLIFrameElement()
          ..src = "assets/packages/flutter_tex/core/flutter_tex.html"
          ..id = _viewId
          ..style.height = '100%'
          ..style.width = '100%'
          ..style.border = '0');

    onTapCallback = onTap.toJS;
    teXViewRenderedCallback = onTeXViewRendered.toJS;

    _isReady = true;

    _initTeXView();
    super.initState();
  }

  void onTap(JSString id) {
    widget.child.onTapCallback(id.toString());
  }

  void onTeXViewRendered(JSNumber message) {
    double viewHeight = double.parse(message.toString());
    if (viewHeight != widgetHeight) {
      setState(() {
        widgetHeight = viewHeight;
      });
    }
  }

  void _initTeXView() {
    if (!_isReady) {
      return;
    }

    var rawData = getRawData(widget);
    if (rawData != _lastData) {
      initWebTeXView(_viewId, rawData);
      _lastData = rawData;
    }
  }
}
