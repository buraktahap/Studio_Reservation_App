import 'package:flutter/material.dart';

class ColoredButtonWithSize extends StatefulWidget {
  const ColoredButtonWithSize(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.width,
      required this.height})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;

  @override
  State<ColoredButtonWithSize> createState() => _ColoredButtonWithSizeState();
}

class _ColoredButtonWithSizeState extends State<ColoredButtonWithSize> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 150,
        height: 35,
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
            widget.text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
