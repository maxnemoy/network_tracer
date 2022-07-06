import 'package:flutter/material.dart' show IconData, Color, Icons, Offset;
import 'package:json_annotation/json_annotation.dart';
import 'package:network_tracer/models/exp.dart';

part 'client_item.g.dart';

enum ConnectionType { manual, dhcp }

@JsonSerializable()
class ClientItem extends INetworkItem {
  final ConnectionType connectionType;
  ClientItem(
      {required super.id,
      required super.title,
      super.offset,
      this.connectionType = ConnectionType.dhcp});

  factory ClientItem.fromJson(Map<String, dynamic> json) =>
      _$ClientItemFromJson(json);
  Map<String, dynamic> toJson() => _$ClientItemToJson(this);

  @override
  IconData get icon => Icons.desktop_mac;

  @override
  Color get color => const Color(0xFFF39C12);

  @override
  INetworkItem copyWith(
          {int? id,
          String? title,
          Offset? offset,
          ConnectionType? connectionType}) =>
      ClientItem(
          id: id ?? this.id,
          title: title ?? this.title,
          offset: offset ?? this.offset,
          connectionType: connectionType ?? this.connectionType);
}