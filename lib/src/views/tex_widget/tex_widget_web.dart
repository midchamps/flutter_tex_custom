import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tex/flutter_tex.dart';

@JS('teX2SVG')
external String teX2SVG(String math, String inputType);

class TeXWidgetState extends State<TeXWidget> {
  @override
  Widget build(BuildContext context) {
    String rawSVG = teX2SVG(widget.math, widget.inputType.value);
    return SvgPicture.string(
      rawSVG,
      height: widget.fontSize,
      width: widget.fontSize,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }
}
