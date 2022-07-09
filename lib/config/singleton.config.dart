// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../logic/services/canvas_scrolling_service/i_canvas_scrolling_service.dart'
    as _i3;
import '../logic/services/navigation/i_navigation_service.dart' as _i4;
import '../ui/bloc/network_data/repository/i_network_data_service.dart' as _i5;

const String _dev = 'dev';
const String _prod = 'prod';
const String _test = 'test';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ICanvasScrollingService>(_i3.CanvasScrollingService(),
      registerFor: {_dev, _prod});
  gh.singleton<_i4.INavigationService>(_i4.NavigationService(),
      registerFor: {_dev, _prod});
  gh.singleton<_i5.INetworkDataService>(_i5.NetworkDataService(),
      registerFor: {_dev, _prod});
  gh.singleton<_i5.INetworkDataService>(_i5.NetworkDataServiceMock(),
      registerFor: {_test});
  return get;
}
