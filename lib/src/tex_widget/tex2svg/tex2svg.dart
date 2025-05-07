import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/tex_widget/utils/input_types.dart';
import 'package:flutter_tex/src/tex_widget/tex2svg/tex2svg_mobile.dart'
    if (dart.library.html) 'package:flutter_tex/src/tex_widget/tex2svg/tex2svg_web.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
class TeX2SVG extends StatefulWidget {
  /// A raw LaTeX string to be rendered.
  final String math;

  /// The type of input math to be rendered.
  final InputType inputType;

  /// Show a loading widget before rendering completes.
  final Widget Function(BuildContext context, String svg)? formulaWidgetBuilder;

  /// Show a loading widget before rendering completes.
  final Widget Function(BuildContext context)? loadingWidgetBuilder;

  const TeX2SVG({
    super.key,
    required this.math,
    this.inputType = InputType.teX,
    this.loadingWidgetBuilder,
    this.formulaWidgetBuilder,
  });

  @override
  TeX2SVGState createState() => TeX2SVGState();
}
