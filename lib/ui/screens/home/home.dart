import 'package:flutter/material.dart';
import 'package:network_tracer/ui/screens/home/bottom_bar.dart';
import 'package:network_tracer/ui/screens/home/net_view.dart';
import 'package:network_tracer/ui/screens/home/right_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: const [NetworkView(), BottomBar(), RightBar()],
    ));
  }
}
