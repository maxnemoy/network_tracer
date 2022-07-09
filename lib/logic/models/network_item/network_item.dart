import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum ConnectorPosition { left, top, right, bottom }


abstract class INetworkItem {
  final int id;
  final String title;
  @JsonKey(fromJson: offsetFromJson, toJson: offsetToJson)
  final Offset offset;

  INetworkItem({required this.id, required this.title, Offset? offset})
      : offset = offset ?? Offset.zero;

  static Offset offsetFromJson(Map<String, dynamic>? o) =>
      o?["dx"] == null || o?["dy"] == null
          ? Offset.zero
          : Offset(o!["dx"] ?? 0, o["dy"] ?? 0);

  static Map<String, double> offsetToJson(Offset o) => {"dx": o.dx, "dy": o.dy};

  ConnectorPosition getConnectorPosition(Offset point, Size size) {
    Offset ip = Offset(offset.dx + size.width / 2, offset.dy + size.height / 2);
    Offset tp = Offset(point.dx + size.width / 2, point.dy + size.height / 2);

    if (ip.dy >= tp.dy) {
      if (ip.dx > tp.dx + size.width) {
        return ConnectorPosition.left;
      }
      if (ip.dx < tp.dx - size.width) {
        return ConnectorPosition.right;
      }
      return ConnectorPosition.top;
    }

    if (ip.dy < tp.dy) {
      if (ip.dx > tp.dx + size.width) {
        return ConnectorPosition.left;
      }
      if (ip.dx < tp.dx - size.height) {
        return ConnectorPosition.right;
      }
      return ConnectorPosition.bottom;
    }
    throw "not impl";
  }

  IconData get icon;
  Color get color;

  INetworkItem copyWith({int? id, String? title, Offset? offset});
}
