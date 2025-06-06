import 'package:flutter/material.dart';
import 'package:flutter_tex/src/tex_widget/tex2svg/tex2svg.dart';
import 'package:flutter_tex/src/tex_widget/utils/parse_tex.dart';

class TeXWidget extends StatelessWidget {
  final String math;
  final TextStyle textStyle;
  final EdgeInsets displayFormulaPadding;

  const TeXWidget({
    super.key,
    required this.math,
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.black),
    this.displayFormulaPadding = const EdgeInsets.symmetric(vertical: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    final segments = parseTeX(math);
    if (segments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildChildren(segments),
    );
  }

  List<Widget> _buildChildren(List<TeXSegment> segments) {
    final List<Widget> columnChildren = [];
    final List<InlineSpan> currentRichTextSpans = [];

    void flushSpans() {
      if (currentRichTextSpans.isNotEmpty) {
        columnChildren.add(
          RichText(
            text: TextSpan(
              style: textStyle,
              children: List.of(currentRichTextSpans),
            ),
          ),
        );
        currentRichTextSpans.clear();
      }
    }

    for (final segment in segments) {
      switch (segment.type) {
        case TeXSegmentType.text:
          currentRichTextSpans.add(
            TextSpan(text: segment.text),
          );
          break;
        case TeXSegmentType.inline:
          currentRichTextSpans.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: TeX2SVG(
              
                math: segment.text,
                // You might want to pass the font size to the SVG renderer
                // to ensure the formula size matches the text.
                // fontSize: textStyle.fontSize,
              ),
            ),
          );
          break;
        case TeXSegmentType.display:
          // 1. First, render any preceding inline text/formulas.
          flushSpans();

          // 2. Then, render the display formula as a new block widget.
          columnChildren.add(
            Padding(
              padding: displayFormulaPadding,
              child: Center(
                child: TeX2SVG(
                  math: segment.text,
                  // You might want a larger font size for display formulas.
                  // fontSize: (textStyle.fontSize ?? 16) * 1.2,
                ),
              ),
            ),
          );
          break;
      }
    }

    // After the loop, flush any remaining spans.
    flushSpans();

    return columnChildren;
  }
}
