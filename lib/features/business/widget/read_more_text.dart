import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final int maxLength;

  const ReadMoreText({
    super.key,
    required this.text,
    this.textStyle,
    this.maxLength = 120, // Default constraint similar to TEXT_CONSTRAINT in React code
  });

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    final isTextLong = widget.text.length > widget.maxLength;
    final displayedText = isReadMore
        ? widget.text
        : (isTextLong ? "${widget.text.substring(0, widget.maxLength)}..." : widget.text);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              text: displayedText,
              style: widget.textStyle ?? const TextStyle(fontSize: 14, color: Colors.black),
              children: isTextLong
                  ? [
                      TextSpan(
                        text: isReadMore ? " Read less" : " Read more",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isReadMore = !isReadMore;
                            });
                          },
                      ),
                    ]
                  : [],
            ),
          ),
        ),
      ],
    );
  }
}
