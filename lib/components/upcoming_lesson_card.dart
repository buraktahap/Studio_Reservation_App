import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/components/colored_button_with_size.dart';

class UpcomingLessonCard extends StatefulWidget {
  final String lesson_name;
  final String lesson_date;
  final String lesson_description;
  // final String lesson_image;
  final String lesson_level;
  final String lesson_time;
  const UpcomingLessonCard({
    Key? key,
    required this.lesson_name,
    required this.lesson_date,
    required this.lesson_description,
    // required this.lesson_image,
    required this.lesson_level,
    required this.lesson_time,
  }) : super(key: key);

  @override
  State<UpcomingLessonCard> createState() => _UpcomingLessonCardState();
}

class _UpcomingLessonCardState extends State<UpcomingLessonCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.lesson_name), Text(widget.lesson_time)]),
            subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.lesson_level,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  Text(
                    widget.lesson_date,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  )
                ]),
          ),
          Image.asset('assets/images/Logo.png'),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ColoredButtonWithSize(
                  text: "Enroll",
                  onPressed: () {},
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 45),
            ],
          ),
        ],
      ),
    );
  }

  ColoredButtonWithSize cardButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return ColoredButtonWithSize(
      text: text,
      onPressed: () {
        onPressed;
        print("Enroll");
      },
      width: MediaQuery.of(context).size.width * 0.4,
      height: 45,
    );
  }
}
