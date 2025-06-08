import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_server_mobile.dart';
import 'package:flutter_tex/src/tex_widget/tex2svg/default_svg_widget.dart';

class TeX2SVGState extends State<TeX2SVG> {
  final TeXRenderingController teXRenderingController =
      TeXRenderingServer.teXRenderingController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: teXRenderingController.webViewControllerPlus
            .runJavaScriptReturningResult(
                "flutterTeXLiteDOM.teX2SVG(${jsonEncode(widget.math)}, '${widget.teXInputType.value}');"),
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
