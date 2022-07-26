import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';

class UpcomingLessonCardV2 extends StatefulWidget {
  // final String lesson_image;
  var data;

  UpcomingLessonCardV2({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<UpcomingLessonCardV2> createState() => _UpcomingLessonCardV2State();
}

class _UpcomingLessonCardV2State extends State<UpcomingLessonCardV2> {
  HomeScreenViewModel viewModel = HomeScreenViewModel();
  @override
  Widget build(BuildContext context) {
    var selectedDate = DateTime.parse(widget.data.lesson.startDate.toString());
    String formattedDate = DateFormat('dd-MM-yyyy  HH:mm').format(selectedDate);
    String formattedDateDay = DateFormat('dd').format(selectedDate);
    String formattedDateDayString = DateFormat('EEEE').format(selectedDate);
    String formattedDateMonth = DateFormat('MMM').format(selectedDate);
    String formattedDateHour = DateFormat('HH:mm').format(selectedDate);
    var selectedTime =
        DateTime.parse(widget.data.lesson.estimatedTime.toString());
    String formattedTime = DateFormat('HH:mm').format(selectedTime);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: (30 / 414) * MediaQuery.of(context).size.width,
      ),
      child: SizedBox(
          height: (150 / 896) * MediaQuery.of(context).size.height,
          width: (354 / 414) * MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment(0.9999982118745121, 0.999980688244732),
                        end: Alignment(0.9999982118745121, -1.0000038146677073),
                        stops: [0.0, 1.0],
                        colors: [
                          Color.fromRGBO(235, 12, 146, 0.2),
                          Color.fromRGBO(255, 170, 146, 0.2)
                        ],
                      ),
                    ),
                    width: (55 / 414) * MediaQuery.of(context).size.width,
                    height: (55 / 896) * MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedDateDay,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        Text(
                          formattedDateMonth,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  littleLine(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 7.5, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(
                    //   height: (12 / 896) * MediaQuery.of(context).size.height,
                    // ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: const Alignment(
                                    0.9999982118745121, 0.999980688244732),
                                end: const Alignment(
                                    0.9999982118745121, -1.0000038146677073),
                                stops: const [0.0, 1.0],
                                colors: [
                                  getColor(),
                                  Colors.white,
                                ],
                              ),
                            ),
                            width:
                                (30 / 414) * MediaQuery.of(context).size.width,
                            height:
                                (30 / 896) * MediaQuery.of(context).size.height,
                            child: Center(
                              child: Icon(
                                Icons.schedule,
                                size: (15 / 414) *
                                    MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                (9 / 414) * MediaQuery.of(context).size.width,
                          ),
                          Text("$formattedDateHour | $formattedTime min",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                          SizedBox(
                            width:
                                (10 / 414) * MediaQuery.of(context).size.width,
                          ),
                          Opacity(
                            opacity: 0.2,
                            child: Text(formattedDateDayString,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                          ),
                        ]),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: (265 / 414) * MediaQuery.of(context).size.width,
                      height: (73 / 896) * MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.data.lesson.name} - ${widget.data.lesson.lessonLevel.toString() == "0" ? "Beginner" : widget.data.lesson.lessonLevel.toString() == "1" ? "Mid" : widget.data.lesson.lessonLevel.toString() == "2" ? "Advanced" : "All"}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${widget.data.lesson.trainer.firstName + " " + widget.data.lesson.trainer.lastName}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Container littleLine() {
    return Container(
      width: 1.0,
      height: (70 / 896) * MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: const Color.fromARGB(78, 33, 35, 56)),
    );
  }

  getColor() {
    Random random = Random();
    Color? color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
    return color;
  }
}
