import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_server_web.dart';
import 'package:flutter_tex/src/tex_widget/tex2svg/default_svg_widget.dart';

class TeX2SVGState extends State<TeX2SVG> {
  @override
  Widget build(BuildContext context) {
    String svg = teX2SVG(widget.math, widget.teXInputType.value);
    return widget.formulaWidgetBuilder?.call(context, svg) ??
        DefaultSVGWidget(svg);
  }
}
