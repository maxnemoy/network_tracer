import 'package:flutter/material.dart';
import 'package:network_tracer/logic/models/exp.dart';
import 'package:network_tracer/ui/components/network_item_presenter.dart';

class RightBar extends StatelessWidget {
  const RightBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(children: [
        NetworkItemPresenter(networkItem: RouterItem.mock()),
        NetworkItemPresenter(networkItem: SwitchItem.mock()),
        NetworkItemPresenter(networkItem: ClientItem.mock()),
      ]),
    );
  }
}
