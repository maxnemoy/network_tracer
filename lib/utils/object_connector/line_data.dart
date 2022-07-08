import 'dart:math' as math;
import 'package:flutter/material.dart' show Offset;

class ConnectionLineData {
  final Offset p1;
  final Offset p2;

  ConnectionLineData(this.p1, this.p2);

  double substituteIntoEquation(Offset point) {
    Offset vector = p2 - p1;
    double A = 1;
    double B = -vector.dx / vector.dy;

    return A * (point.dx - p1.dx) + B * (point.dy - p1.dy);
  }

  Offset middle() {
    return (p1 + p2) / 2;
  }

  bool isParallel(ConnectionLineData other) {
    Offset vector = p2 - p1;
    Offset otherVector = other.p2 - other.p1;

    return vector.direction == otherVector.direction;
  }

  double angle(ConnectionLineData other) {
    var v1 = p2 - p1;
    var v2 = other.p2 - other.p1;

    var cos = (v1.dx * v2.dx + v1.dy * v2.dy) / (v1.distance * v2.distance);

    return math.acos(cos.abs());
  }

  @override
  bool operator ==(Object other) =>
      other is ConnectionLineData &&
      (p1 == other.p1 && p2 == other.p2 || p2 == other.p1 && p1 == other.p2);

  @override
  int get hashCode => p1.hashCode * p2.hashCode;
}
