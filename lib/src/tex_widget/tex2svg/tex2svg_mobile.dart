import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeX2SVGState extends State<TeX2SVG> {
  final WebViewControllerPlus _webViewControllerPlus =
      TeXRenderingServer.webViewControllerPlus;

  final double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _webViewControllerPlus.runJavaScriptReturningResult(
            "teX2SVG(${jsonEncode(widget.math)}, '${widget.inputType.value}');"),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            var svg = jsonDecode(snapshot.data.toString());
            return widget.formulaWidgetBuilder?.call(context, svg) ??
                SvgPicture.string(
                  svg,
                  height: _fontSize,
                  width: _fontSize,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                );
          } else {
            return widget.loadingWidgetBuilder?.call(context) ??
                Text(
                  widget.math,
                  style: TextStyle(fontSize: _fontSize),
                );
          }
        });
  }
}
