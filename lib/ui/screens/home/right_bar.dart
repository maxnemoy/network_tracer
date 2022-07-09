import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_tracer/logic/models/exp.dart';
import 'package:network_tracer/ui/bloc/network_data/data.dart';
import 'package:network_tracer/ui/components/network_item/draggable_network_item.dart';

class RightBar extends StatelessWidget {
  const RightBar({
    Key? key,
  }) : super(key: key);

  void addNetworkItem(
    BuildContext context,
    DraggableDetails details,
    INetworkItem item,
  ) {
    context.read<NetworkDataCubit>().addItem(item, details);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        children: items
            .map((e) => DraggableNetworkItem(
                item: e,
                onDraggable: (details) => addNetworkItem(context, details, e)))
            .toList(),
      ),
    );
  }
}
