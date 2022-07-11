import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';
import 'package:network_tracer/logic/data/example_data.dart';
import 'package:network_tracer/logic/models/exp.dart';

part 'impl/network_data_service.dart';
part 'impl/network_data_service_mock.dart';

abstract class INetworkDataService {
  NetworkConfigData? _data;

  INetworkDataService();

  NetworkConfigData? get networkData => _data;

  Future<void> save();
  Future<NetworkConfigData> load();

  void addNetworkItem(INetworkItem item);
  void removeNetworkItem(INetworkItem item);
  void replaceNetworkItem(INetworkItem item);

  void addConnection(INetworkItem from, INetworkItem to);
}
