part of '../i_network_data_service.dart';

@Singleton(as: INetworkDataService, env: [Environment.dev, Environment.prod])
class NetworkDataService implements INetworkDataService {
  @override
  NetworkConfigData<INetworkItem>? _data;

  @override
  void addNetworkItem(INetworkItem item) {
    List<INetworkItem> list = _data?.items.toList() ?? [];
    list.add(item.copyWith(id: list.length));
    _data = _data?.copyWith(items: list);
  }

  @override
  Future<NetworkConfigData<INetworkItem>> load() async {
    await Future.delayed(const Duration(seconds: 2));

    _data = NetworkConfigData.fromJson(jsonDecode(initialData));

    if (_data != null) {
      return _data!;
    }
    throw ("Load data error");
  }

  @override
  NetworkConfigData<INetworkItem>? get networkData => _data;

  @override
  void removeNetworkItem(INetworkItem item) {}

  @override
  void replaceNetworkItem(INetworkItem item) {
    _data = _data!.replaceItem(item);
  }

  @override
  Future<void> save() {
    throw UnimplementedError();
  }
}
