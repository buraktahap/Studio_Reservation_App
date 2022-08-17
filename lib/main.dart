import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/views/home_view.dart';
import 'package:studio_reservation_app/views/location_selection_view.dart';
import 'package:studio_reservation_app/views/login_view.dart';
import 'package:studio_reservation_app/views/splash_screen.dart';
import 'components/logo.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (BuildContext context, Widget? widget) =>
            MaterialApp( debugShowCheckedModeBanner: false, initialRoute: "/", routes: {
              '/': (context) => const LoginView(),
              '/home': (context) =>  const HomeView(),
              '/location': (context) => LocationSelectionView(),
              '/splash': (context) => const SplashScreen(),
            }));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
