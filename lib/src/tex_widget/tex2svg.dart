import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

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

  /// Show an error widget if rendering fails.
  final WidgetBuilder? errorWidgetBuilder;

  const TeX2SVG({
    super.key,
    required this.math,
    this.teXInputType = TeXInputType.teX,
    this.loadingWidgetBuilder,
    this.formulaWidgetBuilder,
    this.errorWidgetBuilder,
  });

  @override
  State<TeX2SVG> createState() => _TeX2SVGState();
}

class _TeX2SVGState extends State<TeX2SVG> {
  late final Future<String> _texRenderingFuture;

  @override
  void initState() {
    super.initState();
    _texRenderingFuture = TeXRenderingServer.teX2SVG(
      math: widget.math,
      teXInputType: widget.teXInputType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _texRenderingFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            var svg = snapshot.data.toString();
            return widget.formulaWidgetBuilder?.call(context, svg) ??
                SvgPicture.string(
                  svg,
                  height: 16.0,
                  width: 16.0,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                );
          } else {
            if (snapshot.hasError) {
              return widget.errorWidgetBuilder?.call(context) ??
                  Text(
                    'Error rendering TeX: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  );
            }
            return widget.loadingWidgetBuilder?.call(context) ??
                Text(
                  widget.math,
                );
          }
        });
  }
}
