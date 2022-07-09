import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_tracer/config/singleton.dart';
import 'package:network_tracer/logic/services/canvas_scrolling_service/i_canvas_scrolling_service.dart';
import 'package:network_tracer/ui/bloc/network_data/data.dart';
import 'package:network_tracer/ui/components/positioned_wrapper.dart';

class NetworkView extends StatelessWidget {
  const NetworkView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollService = singleton<ICanvasScrollingService>();
    return Scrollbar(
      controller: scrollService.horizontalScrollController,
      scrollbarOrientation: ScrollbarOrientation.bottom,
      child: SingleChildScrollView(
        controller: scrollService.horizontalScrollController,
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: scrollService.verticalScrollController,
          child: SizedBox(
            height: 2000,
            width: 2000,
            child: Stack(
              children: [
                StreamBuilder<Iterable<Widget>>(
                  stream: context.watch<NetworkDataCubit>().lines,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Stack(children: snapshot.data?.toList() ?? []);
                    }
                    context.watch<NetworkDataCubit>().rebuildItems();
                    return Container();
                  }),
                ),
                StreamBuilder<Iterable<PositionedWrapper>>(
                  stream: context.watch<NetworkDataCubit>().items,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context
                            .read<NetworkDataCubit>()
                            .rebuildLines(snapshot.data!.toList());
                      });
                      return Stack(children: snapshot.data?.toList() ?? []);
                    }
                    context.watch<NetworkDataCubit>().rebuildItems();
                    return const CircularProgressIndicator();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
