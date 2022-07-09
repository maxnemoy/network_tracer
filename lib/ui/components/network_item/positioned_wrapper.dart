import 'package:flutter/material.dart';
import 'package:network_tracer/logic/models/exp.dart';
import 'package:network_tracer/ui/components/network_item/draggable_network_item.dart';
import 'package:network_tracer/utils/positioned.dart';

class PositionedWrapper<T extends INetworkItem> extends StatelessWidget
    with PositionedMixin {
  final T item;
  final Function(DraggableDetails details)? onDraggable;
  PositionedWrapper({Key? key, required this.item, this.onDraggable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: item.offset.dx,
        top: item.offset.dy,
        child: DraggableNetworkItem<T>(
          item: item,
          onDraggable: onDraggable,
        ));
  }
}
