import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';

class UpcomingLessonCard extends StatefulWidget {
  final String lessonName;
  final String lessonDate;
  final String lessonDescription;
  final int lessonId;
  // final String lesson_image;
  final String lessonLevel;
  final String lessonTime;
  VoidCallback? detailSetState;
  UpcomingLessonCard(
      {Key? key,
      required this.lessonName,
      required this.lessonDescription,
      required this.lessonId,
      required this.lessonLevel,
      required this.lessonTime,
      required this.lessonDate,
      this.detailSetState})
      : super(key: key);

  @override
  State<UpcomingLessonCard> createState() => _UpcomingLessonCardState();
}

class _UpcomingLessonCardState extends State<UpcomingLessonCard> {
  HomeScreenViewModel viewModel = HomeScreenViewModel();
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
          ],
        ),
      ),
    );
  }
}
