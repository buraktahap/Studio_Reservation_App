import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';

HomeScreenViewModel viewModel = HomeScreenViewModel();

class CompletedLessonCard extends StatefulWidget {
  var data;
  Widget? buttonBar;
  CompletedLessonCard({
    Key? key,
    required this.data,
    this.buttonBar,
  }) : super(key: key);

  @override
  State<CompletedLessonCard> createState() => _CompletedLessonCardState();
}

class _CompletedLessonCardState extends State<CompletedLessonCard> {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.userId);

  @override
  Widget build(BuildContext context) {
    var selectedDate = DateTime.parse(widget.data.lesson.startDate.toString());
    String formattedDate = DateFormat('dd-MM-yyyy  HH:mm').format(selectedDate);
    var selectedTime =
        DateTime.parse(widget.data.lesson.estimatedTime.toString());
    String formattedTime = DateFormat('HH:mm').format(selectedTime);
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.3),
      color: Theme.of(context).primaryColor,
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
                          Text(
                              "${widget.data.lesson.name} - ${widget.data.lesson.lessonLevel == 0 ? "Beginner" : widget.data.lesson.lessonLevel == 1 ? "Mid" : widget.data.lesson.lessonLevel == 2 ? "Advance" : "All"}",
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
            widget.buttonBar ?? Container(),
          ],
        ),
      ),
    );
  }
}
