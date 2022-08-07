import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/components/colored_button_with_size.dart';
import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';

import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';

class UpcomingLessonCard extends StatefulWidget {
  final String lesson_name;
  late String lesson_date;
  final String lesson_description;
  final int lesson_id;
  // final String lesson_image;
  final String lesson_level;
  final String lesson_time;
  UpcomingLessonCard({
    Key? key,
    required this.lesson_name,
    required this.lesson_date,
    required this.lesson_description, // required this.lesson_image,
    required this.lesson_level,
    required this.lesson_time,
    required this.lesson_id,
  }) : super(key: key);

  @override
  State<UpcomingLessonCard> createState() => _UpcomingLessonCardState();
}

@override
State<UpcomingLessonCard> createState() => _UpcomingLessonCardState();
BookingViewModel viewModel = BookingViewModel();

class _UpcomingLessonCardState extends State<UpcomingLessonCard> {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);
  BookingViewModel viewModel = BookingViewModel();

  @override
  Widget build(BuildContext context) {
    var selectedDate = DateTime.parse(widget.lesson_date);
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    var selectedTime = DateTime.parse(widget.lesson_time);
    String formattedTime = DateFormat('HH:mm').format(selectedTime);
    return Card(
      color: const Color(0xff373856),
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.05),
                ),
                Expanded(
                  child: ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.lesson_name + " - " + widget.lesson_level,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                        ]),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            formattedDate + " | " + formattedTime,
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
                ColoredButtonWithSize(
                  text: viewModel.enrollStatus,
                  // onPressed: viewModel.Enroll(memberId, widget.lesson_id),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 45,
                  onPressed: () {
                    viewModel.Enroll(userId!, widget.lesson_id);
                    setState(() {
                      viewModel.enrollStatus;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
