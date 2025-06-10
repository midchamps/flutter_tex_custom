import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart' hide TeXRenderingServer;
import 'package:flutter_tex/src/tex_server/tex_rendering_server_web.dart';
import 'package:flutter_tex/src/tex_widget/tex2svg/default_svg_widget.dart';

class TeX2SVGState extends State<TeX2SVG> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TeXRenderingServer.teX2SVG(
            math: widget.math, teXInputType: widget.teXInputType),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            try {
              var svg = snapshot.data.toString();
              // svg = Platform.isAndroid ? jsonDecode(svg) : svg;
              return widget.formulaWidgetBuilder?.call(context, svg) ??
                  DefaultSVGWidget(svg);
            } catch (e) {
              if (kDebugMode) {
                print('Error rendering TeX: $e');
              }
              return Center(
                child: Text(
                  'Error rendering TeX: ${e.toString()}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          } else {
            return widget.loadingWidgetBuilder?.call(context) ??
                Text(
                  widget.math,
                );
          }
        });
  }
}
