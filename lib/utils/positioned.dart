import 'package:flutter/material.dart';
import 'package:network_tracer/logic/models/network_item/network_item.dart';

mixin PositionedMixin {
  final GlobalKey key = GlobalKey();

  Size get size => (key.currentContext?.findRenderObject() as RenderBox).size;

  Offset globalPosition(Offset scrollOffset) =>
      (key.currentContext?.findRenderObject() as RenderBox)
          .localToGlobal(scrollOffset);

  Offset centerBy(ConnectorPosition pos, Offset scrollOffset) {
    switch (pos) {
      case ConnectorPosition.left:
        return Offset(globalPosition(scrollOffset).dx,
            globalPosition(scrollOffset).dy + size.height / 2);
      case ConnectorPosition.top:
        return Offset(globalPosition(scrollOffset).dx + size.width / 2,
            globalPosition(scrollOffset).dy);
      case ConnectorPosition.right:
        return Offset(globalPosition(scrollOffset).dx + size.width,
            globalPosition(scrollOffset).dy + size.height / 2);
      case ConnectorPosition.bottom:
        return Offset(globalPosition(scrollOffset).dx + size.width / 2,
            globalPosition(scrollOffset).dy + size.height);
      default:
        throw ("unimplemented position");
    }
  }
}
