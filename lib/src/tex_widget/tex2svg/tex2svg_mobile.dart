import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_widget/tex2svg/default_svg_widget.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TeX2SVGState extends State<TeX2SVG> {
  final WebViewControllerPlus _webViewControllerPlus =
      TeXRenderingServer.webViewControllerPlus;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _webViewControllerPlus.runJavaScriptReturningResult(
            "teX2SVG(${jsonEncode(widget.math)}, '${widget.teXInputType.value}');"),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            var svg = snapshot.data.toString();
            svg = Platform.isAndroid ? jsonDecode(svg) : svg;
            return widget.formulaWidgetBuilder?.call(context, svg) ??
                DefaultSVGWidget(svg);
          } else {
            return widget.loadingWidgetBuilder?.call(context) ??
                Text(
                  widget.math,
                );
          }
        });
  }
}
