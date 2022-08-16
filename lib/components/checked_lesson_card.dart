import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/components/colored_button_with_size.dart';
import 'package:studio_reservation_app/models/lesson_response_model.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';
import 'package:studio_reservation_app/views/home_screen_view.dart';

import '../classes/lesson.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';

HomeScreenViewModel viewModel = HomeScreenViewModel();

class CheckedLessonCard extends StatefulWidget {
  final String lesson_date;

  final String lesson_time;

  final String lesson_level;

  final String lesson_name;
  final String text;
  final bool isChecked;

  final int lesson_id;
  const CheckedLessonCard({
    Key? key,
    required this.lesson_date,
    required this.lesson_time,
    required this.lesson_level,
    required this.lesson_name,
    required String lesson_description,
    required this.lesson_id,
    required this.text,
    required this.isChecked,
  }) : super(key: key);

  @override
  State<CheckedLessonCard> createState() => _CheckedLessonCardState();
}

class _CheckedLessonCardState extends State<CheckedLessonCard> {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);

  @override
  Widget build(BuildContext context) {
    var selectedDate = DateTime.parse(widget.lesson_date);
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    var selectedTime = DateTime.parse(widget.lesson_time);
    String formattedTime = DateFormat('HH:mm').format(selectedTime);
    return Card(
      color: const Color(0xff373856),
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Text("Check In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                      backgroundImage:
                          Image.asset('assets/images/trainer1.png').image,
                      radius: MediaQuery.of(context).size.width * 0.05),
                ),
                Expanded(
                  child: ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${widget.lesson_name} - ${widget.lesson_level}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                        ]),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "$formattedDate | $formattedTime",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isChecked == false
                        ? ColoredButtonWithSize(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.3,
                            text: "Check In",
                            onPressed: () {
                              setState(() {
                                HomeScreenViewModel().CheckIn(widget.lesson_id);
                              });
                            },
                          )
                        : Text(widget.text,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
