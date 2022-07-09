import 'package:flutter/material.dart';
import 'package:network_tracer/logic/models/exp.dart';

class NetworkItemPresenter<T extends INetworkItem> extends StatelessWidget {
  final T networkItem;
  const NetworkItemPresenter({super.key, required this.networkItem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 200,
        height: 100,
        color: networkItem.color,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              networkItem.icon,
              size: 50,
              color: Theme.of(context).colorScheme.outline.withOpacity(.8),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Center(
                child: Text(
                  networkItem.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
