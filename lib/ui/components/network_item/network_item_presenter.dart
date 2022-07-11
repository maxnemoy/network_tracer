import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_tracer/logic/models/exp.dart';
import 'package:network_tracer/ui/bloc/network_data/data.dart';

class NetworkItemPresenter<T extends INetworkItem> extends StatefulWidget {
  final T networkItem;
  final bool isConnectionShow;
  const NetworkItemPresenter(
      {super.key, required this.networkItem, this.isConnectionShow = true});

  @override
  State<NetworkItemPresenter<T>> createState() =>
      _NetworkItemPresenterState<T>();
}

class _NetworkItemPresenterState<T extends INetworkItem>
    extends State<NetworkItemPresenter<T>> {
  Alignment? connectorAlignment = Alignment.topCenter;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        width: 200,
        height: 100,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Container(
              color: widget.networkItem.color,
              //margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(
                    widget.networkItem.icon,
                    size: 50,
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(.8),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.networkItem.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  )
                ],
              ),
            ),
           
             Connector(
              data: widget.networkItem,
              alignment: connectorAlignment,
            ),
          ],
        ),
      ),
    );
  }
}

class Connector extends StatelessWidget {
  /// Support only Alignment.topCenter, Alignment.bottomCenter
  final INetworkItem data;
  final Alignment? alignment;
  final double width;
  final double height;
  final Color color;

  const Connector(
      {super.key,
      required this.data,
      this.alignment,
      this.width = 40,
      this.height = 20,
      this.color = Colors.black})
      : assert(alignment != Alignment.topCenter ||
            alignment != Alignment.bottomCenter);

  @override
  Widget build(BuildContext context) {
    return alignment == null
        ? Container()
        : Align(
            alignment: alignment!,
            child: Draggable<INetworkItem>(
              feedback: Container(
                width: height,
                height: height,
                color: color,
              ),
              data: data,
              child: DragTarget<INetworkItem>(
                onAccept: (outputItem) => context
                    .read<NetworkDataCubit>()
                    .addConnection(outputItem, data),
                builder: (context, candidateData, rejectedData) => Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                      topLeft: alignment == Alignment.topCenter
                          ? Radius.zero
                          : Radius.circular(height),
                      topRight: alignment == Alignment.topCenter
                          ? Radius.zero
                          : Radius.circular(height),
                      bottomLeft: alignment == Alignment.bottomCenter
                          ? Radius.zero
                          : Radius.circular(height),
                      bottomRight: alignment == Alignment.bottomCenter
                          ? Radius.zero
                          : Radius.circular(height),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    "+",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: Colors.white),
                  )),
                ),
              ),
            ));
  }
}
