
import 'package:flutter/material.dart';
import 'package:network_tracer/logic/models/exp.dart';
import 'package:network_tracer/ui/components/network_item/network_item_presenter.dart';

class DraggableNetworkItem<T extends INetworkItem> extends StatelessWidget {
  final T item;
  final Function(DraggableDetails details)? onDraggable;
  const DraggableNetworkItem({super.key, required this.item, this.onDraggable});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onDoubleTap: () {},
      child: LongPressDraggable(
        feedback: Opacity(
          opacity: .6,
          child: NetworkItemPresenter(
            networkItem: item,
          ),
        ),
        onDragEnd: (details) {
          onDraggable?.call(details);
        },
        childWhenDragging: Opacity(
          opacity: .2,
          child: NetworkItemPresenter(
            networkItem: item,
          ),
        ),
        child: NetworkItemPresenter(
          networkItem: item,
        ),
      ),
    );
  }
}