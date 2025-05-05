import 'package:flutter/widgets.dart';
import 'package:flutter_tex/src/utils/input_types.dart';
import 'package:flutter_tex/src/views/tex_widget/tex_widget_mobile.dart'
    if (dart.library.html) 'package:flutter_tex/src/views/tex_widget/tex_widget_web.dart';

///A Flutter Widget to render Mathematics / Maths, Physics and Chemistry, Statistics / Stats Equations based on LaTeX with full HTML and JavaScript support.
class TeXWidget extends StatefulWidget {
  /// A raw LaTeX string to be rendered.
  final String math;

  /// The height of the rendered widget.
  final double fontSize;

  /// The type of input math to be rendered.
  final InputType inputType;

  /// Show a loading widget before rendering completes.
  final Widget Function(BuildContext context)? loadingWidgetBuilder;

  const TeXWidget({
    super.key,
    required this.math,
    this.inputType = InputType.teX,
    this.fontSize = 18.0,
    this.loadingWidgetBuilder,
  });

  @override
  TeXWidgetState createState() => TeXWidgetState();
}
