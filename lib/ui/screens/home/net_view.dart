import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_tracer/models/exp.dart';
import 'package:network_tracer/ui/components/line_painter.dart';
import 'package:network_tracer/ui/components/positioned_wrapper.dart';

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
            data = data.replaceItem(e.copyWith(offset: details.offset.translate(scrollingOffset.dx, scrollingOffset.dy)));
            _buildItems();
          }),
        )));
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _buildLines();
    });
  }

  List<Widget> lines = [];

  void _buildLines() {
    lines.clear();

    for (var e in data.connections) {
      var from =
          items.firstWhere((element) => element.item.id == e.from);
      var to = items.firstWhere((element) => element.item.id == e.to);
    
      List<Offset> points = [];

      points.add(from.centerBy(from.item
          .getConnectorPosition(to.item.offset, from.size), scrollingOffset));

      points.add(to.centerBy(to.item
          .getConnectorPosition(from.item.offset, from.size), scrollingOffset));
      lines.add(CustomPaint(
        painter: LinePainter(points: points),
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