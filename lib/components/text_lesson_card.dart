import 'package:flutter/material.dart';

class TextLessonCard extends StatelessWidget {
  final String text;

  const TextLessonCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Card(
        color: const Color(0xff373856),
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Center(
            child: Container(
              height: 146,
              alignment: Alignment.center,
              child: Text(text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
