import 'package:flutter/material.dart';

class VerticalLine extends StatelessWidget {
  final double width;
  final double height;
  final Color topColor;
  final Color bottomColor;

  const VerticalLine({
    super.key,
    required this.width,
    required this.height,
    required this.topColor,
    required this.bottomColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: VerticalLinePainter(topColor: topColor, bottomColor: bottomColor),
    );
  }
}

class VerticalLinePainter extends CustomPainter {
  final Color topColor;
  final Color bottomColor;

  VerticalLinePainter({required this.topColor, required this.bottomColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = size.width * 0.065
      ..style = PaintingStyle.stroke;

    final circleRadius = size.width * 0.17;
    final topCircleCenter = Offset(size.width / 2, size.height * 0.15);
    final bottomCircleCenter = Offset(size.width / 2, size.height * 0.85);

    // Draw top circle
    paint.color = topColor;
    canvas.drawCircle(topCircleCenter, circleRadius, paint);

    // Draw top vertical line
    final topLineStart = Offset(size.width / 2, topCircleCenter.dy + circleRadius);
    final topLineEnd = Offset(size.width / 2, size.height * 0.5);
    canvas.drawLine(topLineStart, topLineEnd, paint);

    // Draw middle horizontal line
    final horizontalLineY = size.height * 0.5;
    canvas.drawLine(Offset(size.width * 0.35, horizontalLineY), Offset(size.width * 0.65, horizontalLineY), paint);

    // Draw bottom vertical line
    paint.color = bottomColor;
    final bottomLineStart = Offset(size.width / 2, size.height * 0.5 + paint.strokeWidth / 2);
    final bottomLineEnd = Offset(size.width / 2, bottomCircleCenter.dy - circleRadius);
    canvas.drawLine(bottomLineStart, bottomLineEnd, paint);

    // Draw bottom circle
    canvas.drawCircle(bottomCircleCenter, circleRadius, paint);

    // Draw inner circles
    paint.style = PaintingStyle.fill;

    // Top inner circle
    paint.color = topColor;
    canvas.drawCircle(topCircleCenter, circleRadius * 0.5, paint);

    // Bottom inner circle
    paint.color = bottomColor;
    canvas.drawCircle(bottomCircleCenter, circleRadius * 0.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
