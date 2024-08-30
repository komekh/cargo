import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double radius;
  final Color color;

  CirclePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Create a paint object with the specified color
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw the circle in the center of the canvas
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CirclePainterWidget extends StatelessWidget {
  final double radius;
  final Color color;

  const CirclePainterWidget({super.key, required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(radius: radius, color: color),
      // Ensure the widget is large enough to fit the circle
      size: Size(radius * 2, radius * 2),
    );
  }
}

class CircleWithGapPainter extends CustomPainter {
  final double radius;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final double gap;

  CircleWithGapPainter({
    required this.radius,
    required this.fillColor,
    required this.borderColor,
    required this.borderWidth,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the inner circle
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    // Paint for the border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    // Draw the filled inner circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      fillPaint,
    );

    // Draw the border circle with the gap
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius + gap + borderWidth / 2,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CircleWithGapWidget extends StatelessWidget {
  final double radius;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final double gap;

  const CircleWithGapWidget({
    super.key,
    required this.radius,
    required this.fillColor,
    required this.borderColor,
    required this.borderWidth,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure the widget is large enough to fit the circle with its border and gap
    double totalSize = (radius + gap + borderWidth) * 2;

    return CustomPaint(
      painter: CircleWithGapPainter(
        radius: radius,
        fillColor: fillColor,
        borderColor: borderColor,
        borderWidth: borderWidth,
        gap: gap,
      ),
      size: Size(totalSize, totalSize),
    );
  }
}
