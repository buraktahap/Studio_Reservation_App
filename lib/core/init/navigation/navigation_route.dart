import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studio_reservation_app/views/sign_in.dart';
import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  get firmId => null;

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {

      // case NavigationConstants.MAIN_VIEWS:
      //   return normalNavigate(MainViews());

      // case NavigationConstants.HOME_VIEW:
      //   return normalNavigate(HomeView());

      // case NavigationConstants.LOGIN_VIA_AZURE_VIEW:
      //   return normalNavigate(LoginView());

      default:
        return MaterialPageRoute(
          builder: (context) => sign_in(),
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
