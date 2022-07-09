part of '../i_canvas_scrolling_service.dart';

@Singleton(
    as: ICanvasScrollingService, env: [Environment.dev, Environment.prod])
class CanvasScrollingService implements ICanvasScrollingService {
  @override
  final ScrollController horizontalScrollController = ScrollController();

  @override
  final ScrollController verticalScrollController = ScrollController();

  @override
  Offset get offset => Offset(
      horizontalScrollController.offset, verticalScrollController.offset);
}
