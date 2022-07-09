// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientItem _$ClientItemFromJson(Map<String, dynamic> json) => ClientItem(
      id: json['id'] as int,
      title: json['title'] as String,
      offset:
          INetworkItem.offsetFromJson(json['offset'] as Map<String, dynamic>?),
      connectionType: $enumDecodeNullable(
              _$ConnectionTypeEnumMap, json['connectionType']) ??
          ConnectionType.dhcp,
    );

Map<String, dynamic> _$ClientItemToJson(ClientItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'offset': INetworkItem.offsetToJson(instance.offset),
      'connectionType': _$ConnectionTypeEnumMap[instance.connectionType]!,
    };

const _$ConnectionTypeEnumMap = {
  ConnectionType.manual: 'manual',
  ConnectionType.dhcp: 'dhcp',
};
