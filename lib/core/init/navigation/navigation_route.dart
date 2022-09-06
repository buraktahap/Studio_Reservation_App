import 'package:flutter/material.dart';
import 'package:studio_reservation_app/views/login_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  get firmId => null;

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {

      // case NavigationConstants.MAIN_VIEWS:
      //   return normalNavigate(MainViews());


      // case NavigationConstants.LOGIN_VIA_AZURE_VIEW:
      //   return normalNavigate(LoginView());

      default:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }

  MaterialPageRoute navigateWithData(Widget widget, dynamic data) {
    return MaterialPageRoute(
        builder: (context) => widget, settings: RouteSettings(arguments: data));
  }
}
