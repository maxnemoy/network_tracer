// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkConfigData<T> _$NetworkConfigDataFromJson<T extends INetworkItem>(
        Map<String, dynamic> json) =>
    NetworkConfigData<T>(
      (json['connections'] as List<dynamic>)
          .map((e) => ConnectionItem.fromJson(e as Map<String, dynamic>)),
      (json['items'] as List<dynamic>)
          .map(_INetworkItemConverter<T>().fromJson),
    );

Map<String, dynamic> _$NetworkConfigDataToJson<T extends INetworkItem>(
        NetworkConfigData<T> instance) =>
    <String, dynamic>{
      'connections': instance.connections.toList(),
      'items': instance.items.map(_INetworkItemConverter<T>().toJson).toList(),
    };
