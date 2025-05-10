import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_widget/tex2svg/default_svg_widget.dart';

@JS('teX2SVG')
external String teX2SVG(String math, String inputType);

class TeX2SVGState extends State<TeX2SVG> {
  @override
  Widget build(BuildContext context) {
    String svg = teX2SVG(widget.math, widget.teXInputType.value);
    return widget.formulaWidgetBuilder?.call(context, svg) ??
        DefaultSVGWidget(svg);
  }
}
