import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TeXWidgetExample extends StatefulWidget {
  const TeXWidgetExample({super.key});

  @override
  State<TeXWidgetExample> createState() => _TeXWidgetExampleState();
}

class _TeXWidgetExampleState extends State<TeXWidgetExample> {
  double fontSize = 18.0;
  TextStyle baseStyle = TextStyle(fontSize: 18.0, color: Colors.black);

  String formula = r"a^2 + b^2 = c^2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TeX Widget Example"),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: [
          RichText(
            text: TextSpan(
              style: baseStyle,
              children: <InlineSpan>[
                const TextSpan(text: 'When'),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: TeXWidget(
                    math: r"a \ne 0",
                    fontSize: fontSize,
                  ),
                ),
                const TextSpan(text: ', there are two solutions to'),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: TeXWidget(
                    math: r"ax^2 + bx + c = 0",
                    fontSize: fontSize,
                  ),
                ),
                const TextSpan(text: ' and they are:'),
              ],
            ),
          ),
          TeXWidget(
              math: r"""x = {-b \pm \sqrt{b^2-4ac} \over 2a}""",
              fontSize: fontSize * 3)
        ],
      ),
    );
  }
}


  // static TeXViewWidget quadraticEquation =
  //     _teXViewWidget(r"<h4>Quadratic Equation</h4>", r"""
  //    When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
  //    $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>""");