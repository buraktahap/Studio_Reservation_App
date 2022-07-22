import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: const Image(
          image: AssetImage("assets/images/Logo.png"),
        ),
      ),
    );
  }
}
