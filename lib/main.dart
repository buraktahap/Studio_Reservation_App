import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/views/sign_in.dart';
import 'package:studio_reservation_app/views/splash_screen.dart';

import 'components/logo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: sign_in(),
      ),
    );
  }
}
