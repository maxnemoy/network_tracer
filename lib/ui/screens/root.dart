import 'package:flutter/material.dart';
import 'package:network_tracer/config/singleton.dart';
import 'package:network_tracer/logic/services/navigation/i_navigation_service.dart';
import 'package:network_tracer/ui/screens/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: singleton<INavigationService>().navigatorKey,
      home: const Home(),
    );
  }
}
