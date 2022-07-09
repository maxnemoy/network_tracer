import 'package:flutter/material.dart';
import 'package:network_tracer/logic/models/exp.dart';
import 'package:network_tracer/ui/components/network_item_presenter.dart';
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
      child: InkWell(
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
      ),
    );
  }
}
