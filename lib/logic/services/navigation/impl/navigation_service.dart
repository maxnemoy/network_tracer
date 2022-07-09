part of '../i_navigation_service.dart';

@Singleton(as: INavigationService, env: [Environment.dev, Environment.prod])
class NavigationService implements INavigationService {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  NavigatorState get navigator => navigatorKey.currentState!;

  @override
  Future showPopUpDialog(
    Widget dialog, {
    bool barrierDismissible = true,
  }) async {
    final context = navigatorKey.currentState!.overlay!.context;

    return await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (_) => dialog,
    );
  }

  @override
  void showTost(String message, {Color? backgroundColor, Duration? duration}) {
    final context = navigatorKey.currentState?.overlay?.context;

    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 1),
      ),
    );
  }
}
