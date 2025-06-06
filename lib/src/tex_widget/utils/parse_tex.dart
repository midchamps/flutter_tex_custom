// void main(List<String> args) {
//   final String latexString =
//       r"This is a test \(x^2 + y^2 = z^2\) and this is another test \[E = mc^2\] and $$a^2 + b^2 = c^2$$ and some text outside $last formular inline$ and $$double dollar formula$$.";

//   final List<TeXSegment> segments = parseTeX(latexString);

//   for (final TeXSegment segment in segments) {
//     print('Text: ${segment.text}, Type: ${segment.type}');
//   }
// }

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

// The order of these doesn't matter, but the order of their use in the RegExp does.
enum TeXDelimiters {
  inlineBrackets(r"(\\\((.*?)\\\))"),
  inlineDollar(r"(\$(.*?)\$)"),
  diplayBrackets(r"(\\\[(.*?)\\\])"),
  displayDollar(r"(\$\$(.*?)\$\$)");

  final String value;

  const TeXDelimiters(this.value);
}

List<TeXSegment> parseTeX(String latexString) {
  final List<TeXSegment> parsedTeXSegments = [];

  // Corrected Order: More specific patterns (double delimiters) come first.
  final RegExp latexRegex = RegExp(
    "${TeXDelimiters.displayDollar.value}|${TeXDelimiters.diplayBrackets.value}|${TeXDelimiters.inlineDollar.value}|${TeXDelimiters.inlineBrackets.value}",
  );

  int lastEnd = 0;

  for (final RegExpMatch match in latexRegex.allMatches(latexString)) {
    if (match.start > lastEnd) {
      final String textSegment = latexString.substring(lastEnd, match.start);
      if (textSegment.isNotEmpty) {
        parsedTeXSegments.add(TeXSegment(textSegment, TeXSegmentType.text));
      }
    }

    // Group indices are updated to match the new RegExp order.
    // displayDollar is now group 2, displayBrackets group 4, etc.
    final String displayDollarContent = match.group(2) ?? "";
    final String displayBracketContent = match.group(4) ?? "";
    final String inlineDollarContent = match.group(6) ?? "";
    final String inlineBracketContent = match.group(8) ?? "";

    // The order of these checks is also updated for clarity.
    if (displayDollarContent.isNotEmpty) {
      parsedTeXSegments
          .add(TeXSegment(displayDollarContent, TeXSegmentType.display));
    } else if (displayBracketContent.isNotEmpty) {
      parsedTeXSegments
          .add(TeXSegment(displayBracketContent, TeXSegmentType.display));
    } else if (inlineDollarContent.isNotEmpty) {
      parsedTeXSegments
          .add(TeXSegment(inlineDollarContent, TeXSegmentType.inline));
    } else if (inlineBracketContent.isNotEmpty) {
      parsedTeXSegments
          .add(TeXSegment(inlineBracketContent, TeXSegmentType.inline));
    }

    lastEnd = match.end;
  }

  if (lastEnd < latexString.length) {
    final String trailingText = latexString.substring(lastEnd);
    if (trailingText.isNotEmpty) {
      parsedTeXSegments.add(TeXSegment(trailingText, TeXSegmentType.text));
    }
  }

  return parsedTeXSegments;
}
