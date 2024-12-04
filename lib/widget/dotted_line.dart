import 'package:flutter/material.dart';

class HorizontalDottedLine extends StatelessWidget {
  final Color color;
  final double dashWidth;
  final double dashHeight;
  final double spacing;

  const HorizontalDottedLine({
    super.key,
    this.color = const Color(0xFFDDDDDD),
    this.dashWidth = 4.0,
    this.dashHeight = 1.0,
    this.spacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, dashHeight),
      painter: _DottedLinePainter(
        color: color,
        dashWidth: dashWidth,
        dashHeight: dashHeight,
        spacing: spacing,
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashHeight;
  final double spacing;

  _DottedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashHeight,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawRect(
        Rect.fromLTWH(startX, 0, dashWidth, dashHeight),
        paint,
      );
      startX += dashWidth + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
