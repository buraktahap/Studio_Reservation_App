import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class colored_button extends StatelessWidget {
  const colored_button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354.0,
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          begin: Alignment(0.9999982118745121, 0.999980688244732),
          end: Alignment(0.9999982118745121, -1.0000038146677073),
          stops: [0.0, 1.0],
          colors: [
            Color.fromARGB(255, 253, 12, 146),
            Color.fromARGB(255, 255, 170, 146)
          ],
        ),
      ),
    );
  }
}
