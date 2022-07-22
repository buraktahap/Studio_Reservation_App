import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/components/input_field.dart';
import 'package:studio_reservation_app/components/logo.dart';

import '../components/background.dart';

class sign_in extends StatefulWidget {
  const sign_in({Key? key}) : super(key: key);

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Background(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              input_field(
                hint: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              input_field(
                hint: 'Password',
                controller: passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              const colored_button()
            ])
          ],
        )
      ],
    );
  }
}
