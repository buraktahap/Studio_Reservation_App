import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/components/action_buttons.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/core/base/base_viewmodel.dart';
import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';

import '../viewmodels/home_screen_view_model.dart';

class LessonDetailPage extends StatefulWidget {
  final String lesson_name;
  final String lesson_date;
  final String lesson_description;
  final int lesson_id;
  // final String lesson_image;
  final String lesson_level;
  final String lesson_time;

  const LessonDetailPage({
    Key? key,
    required this.lesson_name,
    required this.lesson_description,
    required this.lesson_id,
    required this.lesson_level,
    required this.lesson_time,
    required this.lesson_date,
  }) : super(key: key);

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
        viewModel: HomeScreenViewModel(),
        onModelReady: (HomeScreenViewModel model) async {
          await HomeScreenViewModel().getLessonById(widget.lesson_id);
        },
        onPageBuilder: (BuildContext context, HomeScreenViewModel viewModel) =>
            Scaffold(
                extendBody: true,
                extendBodyBehindAppBar: true,
                body: Background(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                          child: FutureBuilder(
                              future: viewModel.getLessonById(widget.lesson_id),
                              initialData:
                                  viewModel.getLessonById(widget.lesson_id),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy')
                                          .format(snapshot.data.startDate)
                                          .toString();
                                  final String formattedTime =
                                      DateFormat('HH:mm')
                                          .format(snapshot.data.startDate)
                                          .toString();

                                  final String duration = DateFormat('HH:mm')
                                      .format(snapshot.data.estimatedTime)
                                      .toString();

                                  return Stack(
                                    children: [
                                      Image.asset('assets/images/asset01.png'),
                                      IconButton(
                                        icon: const Icon(Icons.arrow_back,
                                            color: Colors.white),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      DraggableScrollableSheet(
                                        initialChildSize: 0.55,
                                        minChildSize: 0.5,
                                        maxChildSize: 1,
                                        builder: (context, scrollController) {
                                          return Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xff212338),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30)),
                                              gradient: LinearGradient(
                                                begin: Alignment(
                                                    0.9999982118745121,
                                                    0.999980688244732),
                                                end: Alignment(
                                                    0.9999982118745121,
                                                    -1.0000038146677073),
                                                stops: [0.0, 1.0],
                                                colors: [
                                                  Color.fromRGBO(33, 35, 56, 1),
                                                  Color.fromRGBO(54, 54, 103, 1)
                                                ],
                                              ),
                                            ),
                                            child: SingleChildScrollView(
                                                controller: scrollController,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          30, 25, 30, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          snapshot.data.name,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          snapshot.data.classes
                                                              .name,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                        width: double.infinity,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          snapshot.data
                                                                  .description ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          DetailWithIcon(
                                                              icon:
                                                                  "assets/images/date.png",
                                                              icon_description:
                                                                  "Date ",
                                                              icon_status:
                                                                  formattedDate),
                                                          DetailWithIcon(
                                                              icon:
                                                                  "assets/images/startDate.png",
                                                              icon_description:
                                                                  "Start Time",
                                                              icon_status:
                                                                  formattedTime),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          DetailWithIcon(
                                                            icon:
                                                                "assets/images/level2.png",
                                                            icon_description:
                                                                "Level",
                                                            icon_status: snapshot
                                                                        .data
                                                                        .lessonLevel
                                                                        .toString() ==
                                                                    "1"
                                                                ? "Beginner"
                                                                : snapshot
                                                                            .data
                                                                            .lesson
                                                                            .lessonLevel
                                                                            .toString() ==
                                                                        "2"
                                                                    ? "Intermediate"
                                                                    : snapshot.data.lesson.lessonLevel.toString() ==
                                                                            "3"
                                                                        ? "Advanced"
                                                                        : "All",
                                                          ),
                                                          DetailWithIcon(
                                                              icon:
                                                                  "assets/images/duration.png",
                                                              icon_description:
                                                                  "Duration",
                                                              icon_status:
                                                                  duration),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Divider(
                                                        color: Colors.white
                                                            .withOpacity(0.1),
                                                        thickness: 1,
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                                backgroundImage:
                                                                    Image.asset(
                                                                            'assets/images/trainer1.png')
                                                                        .image,
                                                                radius: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.06),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              snapshot
                                                                      .data
                                                                      .trainer
                                                                      .firstName +
                                                                  " " +
                                                                  snapshot
                                                                      .data
                                                                      .trainer
                                                                      .lastName,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                      ),
                                      ActionButtons(lessonId: widget.lesson_id),
                                      // ...
                                    ],
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              })),
                    ),
                  ],
                ))));
  }
}

class DetailWithIcon extends StatelessWidget {
  final String icon;

  final String icon_description;

  final String icon_status;

  const DetailWithIcon({
    Key? key,
    required this.icon,
    required this.icon_description,
    required this.icon_status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 40,
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  icon_description,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.3), fontSize: 12),
                ),
                Text(
                  icon_status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
