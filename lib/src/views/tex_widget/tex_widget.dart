import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/views/tex_widget/tex_widget_mobile.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
class TeXWidget extends StatefulWidget {
  /// A raw LaTeX string to be rendered.
  final String math;

  /// The height of the rendered widget.
  final double fontSize;

  /// Show a loading widget before rendering completes.
  final Widget Function(BuildContext context)? loadingWidgetBuilder;

  /// Callback when TEX rendering finishes.
  final Function(double height)? onRenderFinished;

  const TeXWidget({
    super.key,
    required this.math,
    this.fontSize = 18.0,
    this.loadingWidgetBuilder,
    this.onRenderFinished,
  });

  @override
  TeXWidgetState createState() => TeXWidgetState();
}
