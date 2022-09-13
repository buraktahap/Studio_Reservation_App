import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_reservation_app/core/base/theme/theme.dart';
import 'package:studio_reservation_app/views/home_view.dart';
import 'package:studio_reservation_app/views/location_selection_view.dart';
import 'package:studio_reservation_app/views/login_view.dart';
import 'package:studio_reservation_app/views/splash_screen.dart';
import 'core/constants/enums/preferences_keys_enum.dart';
import 'core/init/cache/locale_manager.dart';
import 'firebase_options.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint(
          'Message also contained a notification: ${message.notification}');
    }
  });

  final fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM Token: $fcmToken");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isRememberMe;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final preferences = await SharedPreferences.getInstance();
      isRememberMe =
          LocaleManager.instance.getBoolValue(PreferencesKeys.isRememberMe);
      setState(() {
        preferences.setBool("isRememberMe", false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (BuildContext context, Widget? widget) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: isRememberMe == true
                  ? const HomeView()
                  : LoginView(),
              theme: lightTheme,
            ));
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
