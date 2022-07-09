import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'impl/navigation_service.dart';

abstract class INavigationService {
  final GlobalKey<NavigatorState> navigatorKey;

  INavigationService(this.navigatorKey);
  NavigatorState get navigator;

  Future showPopUpDialog(
    Widget dialog, {
    bool barrierDismissible = true,
  });

  void showTost(String message, {Color? backgroundColor, Duration? duration});
}
