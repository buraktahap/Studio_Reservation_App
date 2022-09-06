import 'package:flutter/cupertino.dart';

import 'INavigationService.dart';

class NavigationService implements INavigationService {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final removeAllOldRoutes = (Route<dynamic> route) => false;

  @override
  Future<void> navigateToPage(String path, {Object? data}) async {
    await navigatorKey.currentState?.pushNamed(path, arguments: data);
  }

  @override
  Future<void> navigateToPageClear(String path, {Object? data}) async {
    await navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(path, removeAllOldRoutes, arguments: data);
  }
}

class RouteObserverCall {
  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static final RouteObserverCall _instance = RouteObserverCall._init();
  static RouteObserverCall? get instance => _instance;

  RouteObserver<PageRoute> getRouteObserver() {
    return routeObserver;
  }

  RouteObserverCall._init();
}
