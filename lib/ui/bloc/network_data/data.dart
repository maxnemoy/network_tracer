import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_tracer/config/singleton.dart';
import 'package:network_tracer/logic/models/exp.dart';
import 'package:network_tracer/logic/services/canvas_scrolling_service/i_canvas_scrolling_service.dart';
import 'package:network_tracer/logic/services/navigation/i_navigation_service.dart';
import 'package:network_tracer/ui/components/line_painter.dart';
import 'package:network_tracer/ui/components/network_item/positioned_wrapper.dart';
import 'package:network_tracer/utils/object_connector/object_connector.dart';

import 'repository/i_network_data_service.dart';

class NetworkDataCubit extends Cubit<NetworkConfigData?>
    with ObjectConnectorMixin {
  final INetworkDataService _dataRepository = singleton<INetworkDataService>();

  final StreamController<Iterable<PositionedWrapper>> _itemsStream =
      StreamController.broadcast();
  final StreamController<Iterable<Widget>> _linesStream =
      StreamController.broadcast();

  NetworkDataCubit() : super(null);

  Stream<Iterable<PositionedWrapper>> get items => _itemsStream.stream;
  Stream<Iterable<Widget>> get lines => _linesStream.stream;

  String get rowData => jsonEncode(_dataRepository.networkData?.toJson());

  Future<void> loadData() async {
    if (_dataRepository.networkData == null) {
      await _dataRepository.load();
    }

    if (_dataRepository.networkData != null) {
      return;
    }

    singleton<INavigationService>().showTost("Loading network data failed");
    throw ("Loading network data failed");
  }

  Future<void> rebuildItems() async {
    if (_dataRepository.networkData == null) {
      await loadData();
    }
    List<PositionedWrapper> items = [];

    items.addAll(
      _dataRepository.networkData!.items.map(
        (e) => PositionedWrapper(
          item: e,
          onDraggable: ((details) {
            _dataRepository.replaceNetworkItem(e.copyWith(
              offset: details.offset.translate(
                  singleton<ICanvasScrollingService>().offset.dx,
                  singleton<ICanvasScrollingService>().offset.dy),
            ));
            rebuildItems();
          }),
        ),
      ),
    );
    _itemsStream.add(items);
  }

  void rebuildLines(List<PositionedWrapper> itm) {
    List<Widget> lines = [];

    for (var e in _dataRepository.networkData!.connections) {
      var from = itm.firstWhere((element) => element.item.id == e.from);
      var to = itm.firstWhere((element) => element.item.id == e.to);
      var connection = connectItems(from, to);

      lines.add(CustomPaint(
        painter: LinePainter(points: [
          connection.l1.middle(),
          connection.l2.middle(),
        ]),
      ));
    }
    _linesStream.add(lines);
  }

  void addItem(INetworkItem item, DraggableDetails details) {
    _dataRepository.addNetworkItem(item.copyWith(
      offset: details.offset.translate(
          singleton<ICanvasScrollingService>().offset.dx,
          singleton<ICanvasScrollingService>().offset.dy),
    ));
    rebuildItems();
  }
}
