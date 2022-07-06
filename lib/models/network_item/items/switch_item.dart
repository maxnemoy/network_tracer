import 'package:flutter/material.dart' show IconData, Color, Icons, Offset;

import 'package:json_annotation/json_annotation.dart';
import 'package:network_tracer/models/exp.dart';

part 'switch_item.g.dart';


@JsonSerializable()
class SwitchItem extends INetworkItem {
  final bool isManaged;
  SwitchItem(
      {required super.id,
      required super.title,
      super.offset,
      this.isManaged = false});

  factory SwitchItem.fromJson(Map<String, dynamic> json) =>
      _$SwitchItemFromJson(json);
  Map<String, dynamic> toJson() => _$SwitchItemToJson(this);

  @override
  IconData get icon => Icons.route;

  @override
  Color get color =>
      isManaged ? const Color(0xff1ABC9C) : const Color(0xFF16A085);

  @override
  INetworkItem copyWith(
          {int? id, String? title, Offset? offset, bool? isManaged}) =>
      SwitchItem(
          id: id ?? this.id,
          title: title ?? this.title,
          offset: offset ?? this.offset,
          isManaged: isManaged ?? this.isManaged);
}