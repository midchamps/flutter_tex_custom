import 'dart:async';
import 'dart:js_interop';
import 'dart:ui_web';
import 'package:flutter/material.dart' hide Element;
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_server_web.dart';
import 'package:flutter_tex/src/tex_view/utils/core_utils.dart';
import 'package:web/web.dart';

@JS('initTeXViewWeb')
external void initTeXViewWeb(
    Window iframeContentWindow, String iframId, String flutterTeXData);

class TeXViewState extends State<TeXView> {
  final String _iframeId = UniqueKey().toString();
  final HTMLIFrameElement iframeElement = HTMLIFrameElement()
    ..src = "assets/packages/flutter_tex/core/flutter_tex.html"
    ..style.height = '100%'
    ..style.width = '100%'
    ..style.border = '0';

  final StreamController<double> heightStreamController = StreamController();

  String _lastRawData = '';
  bool _isReady = false;

  late final Window _iframeContentWindow;

  @override
  void initState() {
    TeXViewWebManager.registerInstance(_iframeId, this);

    iframeElement.onLoad.listen((_) {
      _iframeContentWindow = iframeElement.contentWindow!;
      _isReady = true;
      _renderTeXView();
    });

    platformViewRegistry.registerViewFactory(
        _iframeId, (int id) => iframeElement..id = _iframeId);
    // onTeXViewRenderedCallback = onTeXViewRendered.toJS;
    // onTapCallback = onTap.toJS;
    _renderTeXView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _renderTeXView();
    return StreamBuilder<double>(
        stream: heightStreamController.stream,
        builder: (context, snap) {
          return SizedBox(
            height: snap.hasData ? snap.data! : initialHeight,
            child: HtmlElementView(
              key: widget.key ?? ValueKey(_iframeId),
              viewType: _iframeId,
            ),
          );
        });
  }

  void onTap(JSString tapId, JSString viewId) {
    widget.child.onTapCallback(tapId.toString());
  }

  void onTeXViewRendered(JSNumber h, JSString viewId) {
    double height = double.parse(h.toString()) + widget.heightOffset;

    heightStreamController.add(height);
    widget.onRenderFinished?.call(height);
  }

  @override
  void dispose() {
    if (mounted) {
      heightStreamController.close();
    }
    TeXViewWebManager.unregisterInstance(_iframeId);
    super.dispose();
  }

  void _renderTeXView() {
    if (!_isReady) {
      return;
    }
    var currentRawData = getRawData(widget);
    if (currentRawData != _lastRawData) {
      initTeXViewWeb(_iframeContentWindow, _iframeId, currentRawData);
      _lastRawData = currentRawData;
    }
  }
}
