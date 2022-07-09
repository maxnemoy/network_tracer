import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:network_tracer/config/singleton.config.dart';

final singleton = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies({String env = Environment.dev}) async =>
    $initGetIt(singleton, environment: env);
