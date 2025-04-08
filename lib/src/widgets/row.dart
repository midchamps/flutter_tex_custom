import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

/// A widget that displays its children in a vertical array.
class TeXViewRow implements TeXViewWidget {
  /// A list of [TeXViewWidget].
  final List<TeXViewWidget> children;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle? style;

  const TeXViewRow({required this.children, this.style});

  @override
  TeXViewWidgetMeta meta() {
    return const TeXViewWidgetMeta(
        tag: 'div', classList: 'tex-view-row', node: Node.internalChildren);
  }

  @override
  void onTapCallback(String id) {
    for (TeXViewWidget child in children) {
      child.onTapCallback(id);
    }
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': children.map((child) {
          Map childJson = child.toJson();
          childJson['style'] = childJson['style'] +
              '${childJson['style']} display: inline-block;';
          return childJson;
        }).toList(),
        'style':
            'white-space: nowrap; ${style?.initStyle() ?? teXViewDefaultStyle}',
      };
}
