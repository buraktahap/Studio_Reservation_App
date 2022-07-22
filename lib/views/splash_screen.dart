import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/background.dart';
import '../components/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Background(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Logo()],
        )
      ],
    );
  }
}
