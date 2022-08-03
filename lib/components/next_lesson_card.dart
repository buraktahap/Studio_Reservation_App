import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/components/colored_button_with_size.dart';

class NextLessonCard extends StatefulWidget {
  const NextLessonCard({Key? key}) : super(key: key);

  @override
  State<NextLessonCard> createState() => _NextLessonCardState();
}

class _NextLessonCardState extends State<NextLessonCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text('Lesson Name'), Text('22:00')]),
            subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lesson Type-Lesson Level',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  Text(
                    '01/08/2022-Monday',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  )
                ]),
          ),
          Image.asset('assets/images/Logo.png'),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              ColoredButtonWithSize(
                  text: "Check In",
                  onPressed: () {},
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 45),
              ColoredButtonWithSize(
                  text: "Cancel",
                  onPressed: () {},
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 45)
            ],
          ),
        ],
      ),
    );
  }
}
