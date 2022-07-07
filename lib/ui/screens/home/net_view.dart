import 'dart:convert';
import "dart:math" as math;

import 'package:flutter/material.dart';
import 'package:network_tracer/models/exp.dart';
import 'package:network_tracer/ui/components/line_painter.dart';
import 'package:network_tracer/ui/components/positioned_wrapper.dart';

class Line {
  final Offset p1;
  final Offset p2;

  Line(this.p1, this.p2);

  double substituteIntoEquation(Offset point) {
    Offset vector = p2 - p1;
    double A = 1;
    double B = -vector.dx / vector.dy;

    return A * (point.dx - p1.dx) + B * (point.dy - p1.dy);
  }

  Offset middle() {
    return (p1 + p2) / 2;
  }

  bool isParallel(Line other) {
    Offset vector = p2 - p1;
    Offset otherVector = other.p2 - other.p1;

    return vector.direction == otherVector.direction;
  }

  double angle(Line other) {
    var v1 = p2 - p1;
    var v2 = other.p2 - other.p1;

    var cos = (v1.dx * v2.dx + v1.dy * v2.dy) / (v1.distance * v2.distance);

    return math.acos(cos.abs());
  }

  @override
  bool operator ==(Object other) =>
      other is Line &&
      (p1 == other.p1 && p2 == other.p2 || p2 == other.p1 && p1 == other.p2);

  @override
  int get hashCode => p1.hashCode * p2.hashCode;
}

class Connection {
  Connection(this.l1, this.l2);

  final Line l1;
  final Line l2;

  @override
  bool operator ==(Object other) =>
      other is Connection &&
      (l1 == other.l1 && l2 == other.l2 || l1 == other.l2 && l2 == other.l1);

  @override
  int get hashCode => l1.hashCode * l2.hashCode;
}

class NetworkView extends StatefulWidget {
  final NetworkConfigData data;
  const NetworkView({super.key, required this.data});

  @override
  State<NetworkView> createState() => _NetworkViewState();
}

class _NetworkViewState extends State<NetworkView> {
  late NetworkConfigData data;
  List<PositionedWrapper> items = [];

  var verticalScroll = ScrollController();
  var horizontalScroll = ScrollController();

  Offset scrollingOffset = Offset.zero;

  @override
  void initState() {
    data = widget.data;
    _buildItems();
    super.initState();

    verticalScroll.addListener(() {
      scrollingOffset = Offset(horizontalScroll.offset, verticalScroll.offset);
    });

    horizontalScroll.addListener(() {
      scrollingOffset = Offset(horizontalScroll.offset, verticalScroll.offset);
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _buildLines();
    });
  }

  void _buildItems() {
    items.clear();
    items.addAll(data.items.map((e) => PositionedWrapper(
          item: e,
          onDraggable: ((details) {
            data = data.replaceItem(e.copyWith(
                offset: details.offset
                    .translate(scrollingOffset.dx, scrollingOffset.dy)));
            _buildItems();
          }),
        )));
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _buildLines();
    });
  }

  List<Widget> lines = [];

  List<Line> _getRectangelLines(PositionedWrapper rectangle) {
    var topLeft = rectangle.item.offset;
    var topRight = topLeft.translate(rectangle.size.width, 0);
    var bottomLeft = topLeft.translate(0, rectangle.size.height);
    var bottomRight =
        topLeft.translate(rectangle.size.width, rectangle.size.height);

    return [
      Line(topLeft, topRight),
      Line(topRight, bottomRight),
      Line(bottomRight, bottomLeft),
      Line(bottomLeft, topLeft),
    ];
  }

  Offset _getRactangeleCenter(PositionedWrapper positionedWrapper) {
    var topLeft = positionedWrapper.item.offset;
    var bottomRight = topLeft.translate(
        positionedWrapper.size.width, positionedWrapper.size.height);

    return (topLeft + bottomRight) / 2;
  }

  Set<Connection> _getConnections(
      PositionedWrapper rectangle1, PositionedWrapper rectangle2) {
    var lines1 = _getRectangelLines(rectangle1);
    var center1 = _getRactangeleCenter(rectangle1);
    var lines2 = _getRectangelLines(rectangle2);

    Offset p1 = Offset.zero;
    Offset p2 = Offset.zero;
    // p1*p2;
    Set<Connection> connections = {};
    for (var line1 in lines1) {
      for (var line2 in lines2) {
        var middlePoint = line2.middle();
        var r1 = line1.substituteIntoEquation(center1);
        var r2 = line1.substituteIntoEquation(middlePoint);
        if (r1 * r2 < 0) {
          connections.add(Connection(line1, line2));
        }
      }
    }
    return connections;
  }

  Connection _connectItems(
      PositionedWrapper rectangle1, PositionedWrapper rectangle2) {
    // _getMiddlePoints(rectangle1);
    var connections1 = _getConnections(rectangle1, rectangle2);
    var connections2 = _getConnections(rectangle2, rectangle1);
    var connections = connections1.intersection(connections2).toList();

    connections.sort(((c1, c2) {
      // получаем разность между углами в прямоугольном треугольнике
      // тем самым определяем насколько треугольник близок в равнобедренному
      final d1 =
          (math.pi / 2 - 2 * c1.l1.angle(Line(c1.l1.middle(), c1.l2.middle())))
              .abs();
      final d2 =
          (math.pi / 2 - 2 * c2.l1.angle(Line(c2.l1.middle(), c2.l2.middle())))
              .abs();

      return d1.compareTo(d2);
    }));

    return connections.first;
  }

  void _buildLines() {
    lines.clear();

    for (var e in data.connections) {
      var from = items.firstWhere((element) => element.item.id == e.from);
      var to = items.firstWhere((element) => element.item.id == e.to);
      var connection = _connectItems(from, to);

      lines.add(CustomPaint(
        painter: LinePainter(points: [
          connection.l1.middle(),
          connection.l2.middle(),
        ]),
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: horizontalScroll,
      scrollbarOrientation: ScrollbarOrientation.bottom,
      child: SingleChildScrollView(
        controller: horizontalScroll,
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: verticalScroll,
          child: SizedBox(
            height: 2000,
            width: 2000,
            child: Stack(
              children: [
                ...lines,
                ...items,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
