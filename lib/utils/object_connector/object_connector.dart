import "dart:math" as math;
import 'package:flutter/material.dart' show Offset;
import 'package:network_tracer/utils/object_connector/connection_data.dart';
import 'package:network_tracer/utils/object_connector/line_data.dart';
import 'package:network_tracer/ui/components/positioned_wrapper.dart';

mixin ObjectConnectorMixin {
  List<ConnectionLineData> _getRectangleLines(PositionedWrapper rectangle) {
    Offset topLeft = rectangle.item.offset;
    Offset topRight = topLeft.translate(rectangle.size.width, 0);
    Offset bottomLeft = topLeft.translate(0, rectangle.size.height);
    Offset bottomRight =
        topLeft.translate(rectangle.size.width, rectangle.size.height);

    return [
      ConnectionLineData(topLeft, topRight),
      ConnectionLineData(topRight, bottomRight),
      ConnectionLineData(bottomRight, bottomLeft),
      ConnectionLineData(bottomLeft, topLeft),
    ];
  }

  Offset _getRectangleCenter(PositionedWrapper positionedWrapper) {
    var topLeft = positionedWrapper.item.offset;
    var bottomRight = topLeft.translate(
        positionedWrapper.size.width, positionedWrapper.size.height);

    return (topLeft + bottomRight) / 2;
  }

  Set<ConnectionData> _getConnections(
      PositionedWrapper rectangle1, PositionedWrapper rectangle2) {
    List<ConnectionLineData> lines1 = _getRectangleLines(rectangle1);
    Offset center1 = _getRectangleCenter(rectangle1);
    List<ConnectionLineData> lines2 = _getRectangleLines(rectangle2);

    Set<ConnectionData> connections = {};
    for (var line1 in lines1) {
      for (var line2 in lines2) {
        var middlePoint = line2.middle();
        var r1 = line1.substituteIntoEquation(center1);
        var r2 = line1.substituteIntoEquation(middlePoint);
        if (r1 * r2 < 0) {
          connections.add(ConnectionData(line1, line2));
        }
      }
    }
    return connections;
  }

  ConnectionData connectItems(
      PositionedWrapper rectangle1, PositionedWrapper rectangle2) {
    var connections1 = _getConnections(rectangle1, rectangle2);
    var connections2 = _getConnections(rectangle2, rectangle1);
    var connections = connections1.intersection(connections2).toList();

    connections.sort(((c1, c2) {
      // получаем разность между углами в прямоугольном треугольнике
      // тем самым определяем насколько треугольник близок в равнобедренному
      final d1 = (math.pi / 2 -
              2 *
                  c1.l1.angle(
                      ConnectionLineData(c1.l1.middle(), c1.l2.middle())))
          .abs();
      final d2 = (math.pi / 2 -
              2 *
                  c2.l1.angle(
                      ConnectionLineData(c2.l1.middle(), c2.l2.middle())))
          .abs();

      return d1.compareTo(d2);
    }));

    return connections.first;
  }
}
