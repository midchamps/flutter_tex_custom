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

enum TeXDelimiters {
  inlineBrackets(r"(\\\((.*?)\\\))"),
  diplayBrackets(r"(\\\[(.*?)\\\])"),
  displayDollar(r"(\$\$(.*?)\$\$)");

  final String value;

  const TeXDelimiters(this.value);
}

List<TeXSegment> parseLatexString(String latexString) {
  final List<TeXSegment> parsedTeXSegments = [];

  // Regular expression to match LaTeX formulas
  // The regex captures LaTeX formulas in the following groups:
  // It captures the content within the delimiters.

  // Group 2 will capture content of inline formulas \(content\)
  // Group 4 will capture content of display formulas \[content\]
  // Group 6 will capture content of display formulas $$content$$

  final RegExp latexRegex = RegExp(
    r"(\\\((.*?)\\\))|(\\\[(.*?)\\\])|(\$\$(.*?)\$\$)",
  );

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

    // Group 2 will capture content of inline formulas \(content\)
    // Group 4 will capture content of display formulas \[content\]
    // Group 6 will capture content of display formulas $$content$$

    final String? inlineContent = match.group(2);
    final String? displayBracketContent = match.group(4);
    final String? displayDollarContent = match.group(6);

    if (inlineContent != null) {
      final String formula = inlineContent;
      if (formula.isNotEmpty) {
        parsedTeXSegments.add(TeXSegment(formula, TeXSegmentType.inline));
      }
    } else if (displayBracketContent != null) {
      final String formula = displayBracketContent;
      if (formula.isNotEmpty) {
        parsedTeXSegments.add(TeXSegment(formula, TeXSegmentType.display));
      }
    } else if (displayDollarContent != null) {
      final String formula = displayDollarContent;
      if (formula.isNotEmpty) {
        parsedTeXSegments.add(TeXSegment(formula, TeXSegmentType.display));
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
