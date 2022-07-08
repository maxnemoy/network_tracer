import 'package:flutter/material.dart';
import 'package:network_tracer/models/exp.dart';
import 'package:network_tracer/ui/components/line_painter.dart';
import 'package:network_tracer/ui/components/positioned_wrapper.dart';
import 'package:network_tracer/utils/object_connector/object_connector.dart';

class NetworkView extends StatefulWidget {
  final NetworkConfigData data;
  const NetworkView({super.key, required this.data});

  @override
  State<NetworkView> createState() => _NetworkViewState();
}

class _NetworkViewState extends State<NetworkView> with ObjectConnector {
  late NetworkConfigData data;
  List<PositionedWrapper> items = [];

  late ScrollController verticalScroll;
  late ScrollController horizontalScroll;

  Offset scrollingOffset = Offset.zero;

  @override
  void initState() {
    verticalScroll = ScrollController();
    horizontalScroll = ScrollController();
    data = widget.data;
    _buildItems();
    _addScrollListeners();

    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _buildLines();
    });
  }

  void _addScrollListeners() {
    verticalScroll.addListener(() {
      scrollingOffset = Offset(horizontalScroll.offset, verticalScroll.offset);
    });

    horizontalScroll.addListener(() {
      scrollingOffset = Offset(horizontalScroll.offset, verticalScroll.offset);
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

  void _buildLines() {
    lines.clear();

    for (var e in data.connections) {
      var from = items.firstWhere((element) => element.item.id == e.from);
      var to = items.firstWhere((element) => element.item.id == e.to);
      var connection = connectItems(from, to);

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
