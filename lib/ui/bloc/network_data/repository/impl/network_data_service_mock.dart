part of '../i_network_data_service.dart';

@Singleton(as: INetworkDataService, env: [Environment.test])
class NetworkDataServiceMock extends Mock implements INetworkDataService {
  @override
  NetworkConfigData<INetworkItem>? _data;

  @override
  void addNetworkItem(INetworkItem item) {}

  @override
  Future<NetworkConfigData<INetworkItem>> load() {
    throw UnimplementedError();
  }

  @override
  NetworkConfigData<INetworkItem>? get networkData =>
      throw UnimplementedError();

  @override
  void removeNetworkItem(INetworkItem item) {}

  @override
  void replaceNetworkItem(INetworkItem item) {}

  @override
  Future<void> save() {
    throw UnimplementedError();
  }
}
