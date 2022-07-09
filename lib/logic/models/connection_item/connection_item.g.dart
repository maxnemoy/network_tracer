// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionItem _$ConnectionItemFromJson(Map<String, dynamic> json) =>
    ConnectionItem(
      from: json['from'] as int,
      to: json['to'] as int,
    );

Map<String, dynamic> _$ConnectionItemToJson(ConnectionItem instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
    };
