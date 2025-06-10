import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/tex_widget/utils/tex_input_types.dart';
import 'package:flutter_tex/src/tex_widget/tex2svg/tex2svg_mobile.dart'
    if (dart.library.html) 'package:flutter_tex/src/tex_widget/tex2svg/tex2svg_web.dart';

///A pure Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX.
class TeX2SVG extends StatefulWidget {
  /// A raw LaTeX string to be rendered.
  final String math;

  /// The type of input math to be rendered. Default is [TeXInputType.teX].
  final TeXInputType teXInputType;

  /// Show a loading widget before rendering completes.
  final Widget Function(BuildContext context, String svg)? formulaWidgetBuilder;

  /// Show a loading widget before rendering completes.
  final Widget Function(BuildContext context)? loadingWidgetBuilder;

  const TeX2SVG({
    super.key,
    required this.math,
    this.teXInputType = TeXInputType.teX,
    this.loadingWidgetBuilder,
    this.formulaWidgetBuilder,
  });

  @override
  TeX2SVGState createState() => TeX2SVGState();
}
