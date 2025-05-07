import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

@JS('teX2SVG')
external String teX2SVG(String math, String inputType);

class TeX2SVGState extends State<TeX2SVG> {
  final double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    String svg = teX2SVG(widget.math, widget.inputType.value);
    return widget.formulaWidgetBuilder?.call(context, svg) ??
        SvgPicture.string(
          svg,
          height: _fontSize,
          width: _fontSize,
          fit: BoxFit.contain,
          alignment: Alignment.center,
        );
  }
}
