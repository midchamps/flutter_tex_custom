import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TeXWidgetExamples extends StatelessWidget {
  const TeXWidgetExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("TeXView Fonts"),
      ),
      body: TeXWidget(
          math:
              r"This is a test \(x^2 + y^2 = z^2\) and this is another test \[E = mc^2\] and $$a^2 + b^2 = c^2$$ and some text outside $last formular inline$."
              "\n\n\n\n\n dkfjdkfj"),
    );
  }
}
