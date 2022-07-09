import 'package:flutter/material.dart' show IconData, Color, Icons, Offset;
import 'package:json_annotation/json_annotation.dart';
import 'package:network_tracer/logic/models/exp.dart';

part 'router_item.g.dart';

@JsonSerializable()
class RouterItem extends INetworkItem {
  RouterItem({required super.id, required super.title, super.offset});

  RouterItem.mock() : super(id: 1, offset: Offset.zero, title: "Router");

  factory RouterItem.fromJson(Map<String, dynamic> json) =>
      _$RouterItemFromJson(json);
  Map<String, dynamic> toJson() => _$RouterItemToJson(this);

  @override
  IconData get icon => Icons.router;

  @override
  Color get color => const Color(0xff2980B9);

  @override
  INetworkItem copyWith({int? id, String? title, Offset? offset}) => RouterItem(
      id: id ?? this.id,
      title: title ?? this.title,
      offset: offset ?? this.offset);
}
