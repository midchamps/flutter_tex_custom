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
            "TeX2SVG(${jsonEncode(widget.math)});"),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            return SvgPicture.string(
              jsonDecode(snapshot.data.toString())
                  .replaceFirst(
                      "<mjx-container class=\"MathJax\" jax=\"SVG\">", "")
                  .replaceFirst("</mjx-container>", ""),
              height: widget.fontSize,
              width: widget.fontSize,
            );
          } else {
            return Text(
              widget.math,
              style: TextStyle(fontSize: widget.fontSize),
            );
          }
        });
  }
}
