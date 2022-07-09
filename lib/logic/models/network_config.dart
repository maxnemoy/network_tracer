import 'package:json_annotation/json_annotation.dart';
import 'package:network_tracer/logic/models/exp.dart';

part 'network_config.g.dart';

@JsonSerializable()
class NetworkConfigData<T extends INetworkItem> {
  final Iterable<ConnectionItem> connections;
  @_INetworkItemConverter()
  final Iterable<T> items;

  NetworkConfigData(this.connections, this.items);

  factory NetworkConfigData.fromJson(Map<String, dynamic> json) =>
      _$NetworkConfigDataFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkConfigDataToJson(this);

  NetworkConfigData<T> copyWith(
          {Iterable<ConnectionItem>? connections, Iterable<T>? items}) =>
      NetworkConfigData(connections ?? this.connections, items ?? this.items);

  NetworkConfigData<T> replaceItem(T newItem) {
    Iterable<T> newItems = items.toList()
      ..removeWhere((element) => element.id == newItem.id)
      ..add(newItem);
    return NetworkConfigData(connections, newItems);
  }
}

class _INetworkItemConverter<T> implements JsonConverter<T, Object?> {
  const _INetworkItemConverter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic> && json.containsKey('connectionType')) {
      return ClientItem.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> && json.containsKey('isManaged')) {
      return SwitchItem.fromJson(json) as T;
    }
    return RouterItem.fromJson(json as Map<String, dynamic>) as T;
  }

  @override
  Object? toJson(T object) => object;
}
