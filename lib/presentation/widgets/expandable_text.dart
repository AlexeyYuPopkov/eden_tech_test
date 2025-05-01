import 'package:eden_tech_test/l10n/localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

final class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? moreTextStyle;
  final int maxLines;

  const ExpandableText({
    super.key,
    required this.text,
    this.style,
    this.moreTextStyle,
    required this.maxLines,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

final class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  void _toggleExpanded() => setState(() => _isExpanded = !_isExpanded);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: widget.style,
        );

        final painter = TextPainter(
          text: textSpan,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );

        painter.layout(maxWidth: constraints.maxWidth);

        final isOverflowing = painter.didExceedMaxLines;

        final endOffset = painter
            .getPositionForOffset(Offset(constraints.maxWidth, painter.height))
            .offset;

        const visibleTextSuffix = '... ';
        const visibleTextSuffixLength = visibleTextSuffix.length;

        final moreSuffix = context.moreSuffix;

        final visibleLength = endOffset - visibleTextSuffixLength;

        final visibleText = visibleLength <= 0
            ? widget.text
            : widget.text.substring(0, visibleLength);

        final maxLinesAndMoreButtonLine = widget.maxLines + 1;

        return RichText(
          textScaler: MediaQuery.textScalerOf(context),
          maxLines: _isExpanded ? null : maxLinesAndMoreButtonLine,
          textAlign: TextAlign.start,
          text: TextSpan(
            text: (_isExpanded || !isOverflowing
                ? widget.text
                : '${visibleText.trim()}$visibleTextSuffix'),
            style: widget.style,
            children: [
              if (isOverflowing && !_isExpanded)
                TextSpan(
                  text: ('\n$moreSuffix'),
                  style: _getMoreButtonStyle(context),
                  recognizer: TapGestureRecognizer()..onTap = _toggleExpanded,
                ),
            ],
          ),
        );
      },
    );
  }

  TextStyle? _getMoreButtonStyle(BuildContext context) {
    return widget.moreTextStyle ??
        widget.style?.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
        );
  }
}

extension on BuildContext {
  String get moreSuffix => l10n.commonTextMoreButtonMoreSuffix;
}
