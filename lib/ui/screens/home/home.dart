import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_tracer/data/example_data.dart';
import 'package:network_tracer/models/exp.dart';
import 'package:network_tracer/ui/screens/home/net_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late NetworkConfigData<INetworkItem> data;

  @override
  void initState() {
    data = NetworkConfigData.fromJson(jsonDecode(initialData));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: NetworkView(
            data: data,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: const Text("export"),
                onPressed: () {
                  debugPrint(jsonEncode(data.toJson()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
