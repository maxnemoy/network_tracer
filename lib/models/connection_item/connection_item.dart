import 'package:json_annotation/json_annotation.dart';

part 'connection_item.g.dart';

@JsonSerializable()
class ConnectionItem {
  final int from;
  final int to;

  ConnectionItem({required this.from, required this.to});

  factory ConnectionItem.fromJson(Map<String, dynamic> json) => _$ConnectionItemFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectionItemToJson(this);
}