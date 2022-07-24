import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  const ColoredButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 354.0,
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: const LinearGradient(
            begin: Alignment(0.9999982118745121, 0.999980688244732),
            end: Alignment(0.9999982118745121, -1.0000038146677073),
            stops: [0.0, 1.0],
            colors: [
              Color.fromARGB(255, 253, 12, 146),
              Color.fromARGB(255, 255, 170, 146)
            ],
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
