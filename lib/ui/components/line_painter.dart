import 'dart:ui' show PointMode;

import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final List<Offset> points;

  LinePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    const pointMode = PointMode.polygon;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
