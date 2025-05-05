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
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                style: baseStyle,
                children: <InlineSpan>[
                  const TextSpan(text: 'This is some text before the icon. '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: TeXWidget(
                      math: formula,
                      fontSize: fontSize,
                    ),
                  ),
                  const TextSpan(text: ' Here is some text after the icon.'),
                  const TextSpan(text: ' You can add more text and icons '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: TeXWidget(
                        math:
                            r"""$$Hg^2+ ->[I-] HgI2 ->[I-] [Hg^{II}I4]^2-$$""",
                        fontSize: fontSize),
                  ),
                  const TextSpan(text: ' like this.'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
