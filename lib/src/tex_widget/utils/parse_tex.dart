enum TeXSegmentType {
  text,
  inline,
  display,
}

class TeXSegment {
  final String text;
  final TeXSegmentType type;

  TeXSegment(this.text, this.type);
}

List<TeXSegment> parseLatexString(String latexString) {
  final List<TeXSegment> parsedTeXSegments = [];
  // Regex to find \(inline formula\) or \[display formula\]
  // It captures the content within the delimiters.
  // Group 2 will capture content of display formulas \[content\]
  // Group 4 will capture content of inline formulas \(content\)
  final RegExp latexRegex = RegExp(r"(\\\[(.*?)\\\])|(\\\((.*?)\\\))");

  int lastEnd = 0;

  for (final RegExpMatch match in latexRegex.allMatches(latexString)) {
    // Add the text segment before the current LaTeX match
    if (match.start > lastEnd) {
      final String textSegment = latexString.substring(lastEnd, match.start);
      if (textSegment.isNotEmpty) {
        parsedTeXSegments.add(TeXSegment(textSegment, TeXSegmentType.text));
      }
    }

    // Extract content from the matched LaTeX formula
    // Group 2 is for display formulas: \[content\]
    // Group 4 is for inline formulas: \(content\)
    final String? displayContent = match.group(2);
    final String? inlineContent = match.group(4);

    if (displayContent != null) {
      final String formula = displayContent;
      if (formula.isNotEmpty) {
        parsedTeXSegments.add(TeXSegment(formula, TeXSegmentType.display));
      }
    } else if (inlineContent != null) {
      final String formula = inlineContent;
      if (formula.isNotEmpty) {
        parsedTeXSegments.add(TeXSegment(formula, TeXSegmentType.inline));
      }
    }

    lastEnd = match.end;
  }

  // Add any remaining text after the last LaTeX match
  if (lastEnd < latexString.length) {
    final String trailingText = latexString.substring(lastEnd);
    if (trailingText.isNotEmpty) {
      parsedTeXSegments.add(TeXSegment(trailingText, TeXSegmentType.text));
    }
  }

  return parsedTeXSegments;
}