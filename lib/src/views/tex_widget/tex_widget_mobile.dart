import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeXWidgetState extends State<TeXWidget> {
  final WebViewControllerPlus _webViewControllerPlus =
      TeXRenderingServer.webViewControllerPlus;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _webViewControllerPlus.runJavaScriptReturningResult(
            "teX2SVG(${jsonEncode(widget.math)}, '${widget.inputType.value}');"),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            var rawSVG = jsonDecode(snapshot.data.toString());
            return SvgPicture.string(
              rawSVG,
              height: widget.fontSize,
              width: widget.fontSize,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            );
          } else {
            return widget.loadingWidgetBuilder?.call(context) ??
                Text(
                  widget.math,
                  style: TextStyle(),
                );
          }
        });
  }
}
