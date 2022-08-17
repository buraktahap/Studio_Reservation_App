import 'package:flutter/material.dart';

/* Rectangle Border
    Autogenerated by FlutLab FTF Generator
  */
class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.controller,
    required this.hint,
    this.icon,
    this.isObscure,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final bool? isObscure;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1,
      child: Container(
        width: 355.0,
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            width: 1.0,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
          child: TextFormField(
              style: const TextStyle(color: Colors.white),
              obscureText: isObscure == null ? false : true,
              inputFormatters: const [],
              controller: controller,
              showCursor: true,
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: InputBorder.none,
                  suffixIcon: icon)),
        ),
      ),
    );
  }
}
