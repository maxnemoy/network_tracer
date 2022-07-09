// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwitchItem _$SwitchItemFromJson(Map<String, dynamic> json) => SwitchItem(
      id: json['id'] as int,
      title: json['title'] as String,
      offset:
          INetworkItem.offsetFromJson(json['offset'] as Map<String, dynamic>?),
      isManaged: json['isManaged'] as bool? ?? false,
    );

Map<String, dynamic> _$SwitchItemToJson(SwitchItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'offset': INetworkItem.offsetToJson(instance.offset),
      'isManaged': instance.isManaged,
    };
