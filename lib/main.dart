import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/views/login_view.dart';
import 'package:studio_reservation_app/views/splash_screen.dart';

import 'components/logo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (BuildContext context, Widget? widget) => const MaterialApp(
              home: Scaffold(
                body: LoginView(),
              ),
            ));
  }
}
