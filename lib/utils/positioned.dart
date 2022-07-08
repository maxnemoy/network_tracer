import 'package:flutter/material.dart';
import 'package:network_tracer/models/network_item/network_item.dart';

mixin PositionedMixin {
  final GlobalKey key = GlobalKey();

  Size get size => (key.currentContext?.findRenderObject() as RenderBox).size;

  Offset globalPosition(Offset o) =>
      (key.currentContext?.findRenderObject() as RenderBox)
          .localToGlobal(o);

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