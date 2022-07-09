// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouterItem _$RouterItemFromJson(Map<String, dynamic> json) => RouterItem(
      id: json['id'] as int,
      title: json['title'] as String,
      offset:
          INetworkItem.offsetFromJson(json['offset'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$RouterItemToJson(RouterItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'offset': INetworkItem.offsetToJson(instance.offset),
    };
