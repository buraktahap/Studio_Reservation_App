import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';

class EnrollLessonCard extends StatefulWidget {
  var data;

  Widget? buttonOrText;
  // late Widget buttonBar;
  EnrollLessonCard({
    Key? key,
    required this.buttonOrText,
    required this.data,
  }) : super(key: key);

  @override
  State<EnrollLessonCard> createState() => _EnrollLessonCardState();
}

@override
State<EnrollLessonCard> createState() => _EnrollLessonCardState();

class _EnrollLessonCardState extends State<EnrollLessonCard> {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.userId);
  BookingViewModel viewModel = BookingViewModel();
  @override
  Widget build(BuildContext context) {
    var selectedDate = DateTime.parse(widget.data.startDate.toString());
    String formattedDate = DateFormat('dd-MM-yyyy  HH:mm').format(selectedDate);
    var selectedTime = DateTime.parse(widget.data.estimatedTime.toString());
    String formattedTime = DateFormat('HH:mm').format(selectedTime);
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      color: Theme.of(context).primaryColor,
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
                              "${widget.data.name} - ${widget.data.lessonLevel}",
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
            widget.buttonOrText!,
          ],
        ),
      ),
    );
  }
}
