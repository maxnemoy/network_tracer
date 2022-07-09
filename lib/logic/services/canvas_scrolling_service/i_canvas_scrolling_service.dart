// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart' show ScrollController, Offset;
import 'package:injectable/injectable.dart';

part 'impl/canvas_scrolling_service.dart';

abstract class ICanvasScrollingService {
  final ScrollController verticalScrollController;
  final ScrollController horizontalScrollController;

  ICanvasScrollingService(
      this.verticalScrollController, this.horizontalScrollController);

  Offset get offset;
}
