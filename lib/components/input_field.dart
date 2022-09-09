import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.controller,
    required this.hint,
    this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
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
            color: Theme.of(context).shadowColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
          child: TextFormField(
              inputFormatters: const [],
              controller: controller,
              showCursor: true,
              textInputAction: TextInputAction.next,
              cursorColor: Theme.of(context).buttonTheme.colorScheme?.onSurface,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: hint,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: InputBorder.none,
                  suffixIcon: icon)),
        ),
      ),
    );
  }
}
