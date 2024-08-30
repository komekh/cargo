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
