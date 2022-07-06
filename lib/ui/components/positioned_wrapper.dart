import 'package:flutter/material.dart';
import 'package:network_tracer/models/network_item/network_item.dart';

class PositionedWrapper<T extends INetworkItem> extends StatelessWidget with PositionedMixin {
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
          onTap: () {
            
          },
          onDoubleTap: () {
            
          },
          child: LongPressDraggable(
            feedback: Opacity(
              opacity: .6,
              child: NetworkItemPresenter(networkItem: item,),
            ),
            onDragEnd: (details) {
              onDraggable?.call(details);
            },
            childWhenDragging: Opacity(
              opacity: .2,
              child: NetworkItemPresenter(networkItem: item,),
            ),
            child: NetworkItemPresenter(networkItem: item,),
          ),
        ));
  }
}

mixin PositionedMixin {
  final GlobalKey key = GlobalKey();

  Size get size => (key.currentContext?.findRenderObject() as RenderBox).size;

  Offset globalPosition(Offset o) =>
      (key.currentContext?.findRenderObject() as RenderBox)
          .localToGlobal(o);

  // Rect get globalPaintBounds {
  //   final renderObject = key.currentContext?.findRenderObject();
  //   var translation = renderObject?.getTransformTo(null).getTranslation();

  //   return renderObject!.paintBounds
  //       .shift(Offset(translation!.x, translation.y));
  // }

  //   Offset get globalPosition {
  //   final renderObject = key.currentContext?.findRenderObject();
  //   var translation = renderObject?.getTransformTo(null).getTranslation();

  //   return Offset(translation!.x, translation.y);
  // }

  Offset centerBy(ConnectorPosition pos, Offset o) {
    switch (pos) {
      case ConnectorPosition.left:
        return Offset(globalPosition(o).dx, globalPosition(o).dy + size.height / 2);
      case ConnectorPosition.top:
        return Offset(globalPosition(o).dx + size.width / 2, globalPosition(o).dy);
      case ConnectorPosition.right:
        return Offset(globalPosition(o).dx + size.width,
            globalPosition(o).dy + size.height / 2);
      case ConnectorPosition.bottom:
        return Offset(globalPosition(o).dx + size.width / 2,
            globalPosition(o).dy + size.height);
      default:
        return Offset(globalPosition(o).dx + size.width / 2, globalPosition(o).dy);
    }
  }
}

class NetworkItemPresenter<T extends INetworkItem> extends StatelessWidget {
  final T networkItem;
  const NetworkItemPresenter({super.key, required this.networkItem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 200,
        height: 100,
        color: networkItem.color,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(networkItem.icon, size: 50, color: Theme.of(context).colorScheme.outline.withOpacity(.8),),
            const SizedBox(width: 5,),
            Expanded(child: Center(child: Text(networkItem.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge,)))
          ],
        ),
      ),
    );
  }
}
