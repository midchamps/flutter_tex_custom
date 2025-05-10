import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class DefaultSVGWidget extends StatelessWidget {
  final String svg;
  const DefaultSVGWidget(this.svg, {super.key});
  final double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      svg,
      height: _fontSize,
      width: _fontSize,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }
}
