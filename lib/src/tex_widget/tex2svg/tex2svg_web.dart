import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_server_web.dart';
import 'package:flutter_tex/src/tex_widget/tex2svg/default_svg_widget.dart';

class TeX2SVGState extends State<TeX2SVG> {
  @override
  Widget build(BuildContext context) {
    try {
      String svg = teX2SVG(widget.math, widget.teXInputType.value);
      return widget.formulaWidgetBuilder?.call(context, svg) ??
          DefaultSVGWidget(svg);
    } catch (e) {
      if (kDebugMode) {
        print('Error rendering TeX: $e');
      }
      // Handle any exceptions that may occur during rendering
      return Center(
        child: Text(
          'Error rendering TeX: ${e.toString()}',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }
}
