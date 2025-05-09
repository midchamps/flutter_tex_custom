import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

main() async {
  if (!kIsWeb) {
    await TeXRenderingServer.start();
  }
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TeX2SVGExample(),
  ));
}

class TeX2SVGExample extends StatefulWidget {
  const TeX2SVGExample({super.key});

  @override
  State<TeX2SVGExample> createState() => _TeX2SVGExampleState();
}

class _TeX2SVGExampleState extends State<TeX2SVGExample> {
  double fontSize = 18.0;
  TextStyle baseStyle = TextStyle(fontSize: 18.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("TeX2SVG Example"),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 4),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Quadratic Formula",
                    style: baseStyle.copyWith(
                      fontSize: fontSize * 1.5,
                      color: Colors.black,
                    )),
                RichText(
                  text: TextSpan(
                    style: baseStyle,
                    children: <InlineSpan>[
                      const TextSpan(text: 'When '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TeX2SVG(
                          teXInputType: TeXInputType.teX,
                          math: r"a \ne 0",
                        ),
                      ),
                      const TextSpan(text: ', there are two solutions to'),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TeX2SVG(
                          math: r"ax^2 + bx + c = 0",
                        ),
                      ),
                      const TextSpan(text: ' and they are:'),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                TeX2SVG(
                  math: r"""x = {-b \pm \sqrt{b^2-4ac} \over 2a}""",
                  formulaWidgetBuilder: (context, svg) {
                    double displayFontSize = fontSize * 3;
                    return SvgPicture.string(
                      svg,
                      height: displayFontSize,
                      width: displayFontSize,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
