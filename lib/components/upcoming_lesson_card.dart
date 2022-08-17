import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';

class UpcomingLessonCard extends StatefulWidget {
  final String lesson_name;
  final String lesson_date;
  final String lesson_description;
  final int lesson_id;
  // final String lesson_image;
  final String lesson_level;
  final String lesson_time;
  VoidCallback? onPressed;
  UpcomingLessonCard(
      {Key? key,
      required this.lesson_name,
      required this.lesson_description,
      required this.lesson_id,
      required this.lesson_level,
      required this.lesson_time,
      required this.lesson_date,
      this.onPressed})
      : super(key: key);

  @override
  State<UpcomingLessonCard> createState() => _UpcomingLessonCardState();
}

class _UpcomingLessonCardState extends State<UpcomingLessonCard> {
  HomeScreenViewModel viewModel = HomeScreenViewModel();
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
            Container(
              alignment: Alignment.topLeft,
              child: const Text("Upcoming Lesson",
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
              alignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.onPressed,
                  child: const Text(
                    "See All",
                    style: TextStyle(
                        color: Color.fromARGB(255, 253, 12, 146), fontSize: 16),
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
