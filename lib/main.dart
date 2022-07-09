import 'package:flutter/material.dart';
import 'package:network_tracer/config/block_wrapper.dart';
import 'package:network_tracer/config/singleton.dart';
import 'package:network_tracer/ui/screens/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const BlocWrapper(
    child: App(),
  ));
}
