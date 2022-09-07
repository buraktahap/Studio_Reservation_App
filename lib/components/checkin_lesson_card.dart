import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';

HomeScreenViewModel viewModel = HomeScreenViewModel();

class CheckInLessonCard extends StatefulWidget {
  final String lessonDate;

  final String lessonTime;

  final String lessonLevel;

  final String lessonName;
  late bool isChecked;
  late Widget buttonBar;
  final int lessonId;
  CheckInLessonCard({
    Key? key,
    required this.lessonDate,
    required this.lessonTime,
    required this.lessonLevel,
    required this.lessonName,
    required String lessonDescription,
    required this.lessonId,
    required this.isChecked,
    required this.buttonBar,
  }) : super(key: key);

  @override
  State<CheckInLessonCard> createState() => _CheckInLessonCardState();
}

class _CheckInLessonCardState extends State<CheckInLessonCard> {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.userId);

  @override
  Widget build(BuildContext context) {
    var selectedDate = DateTime.parse(widget.lessonDate);
    String formattedDate = DateFormat('dd-MM-yyyy  HH:mm').format(selectedDate);
    var selectedTime = DateTime.parse(widget.lessonTime);
    String formattedTime = DateFormat('HH:mm').format(selectedTime);
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.3),
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                      backgroundImage:
                          Image.asset('assets/images/trainer1.png').image,
                      radius: MediaQuery.of(context).size.width * 0.05),
                ),
                Expanded(
                  child: ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${widget.lessonName} - ${widget.lessonLevel}",
                              style: const TextStyle(fontSize: 20)),
                        ]),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "$formattedDate | $formattedTime",
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            widget.buttonBar,
          ],
        ),
      ),
    );
  }
}
