import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/action_buttons.dart';
import 'package:studio_reservation_app/components/checked_lesson_card.dart';
import 'package:studio_reservation_app/components/checkin_lesson_card.dart';
import 'package:studio_reservation_app/components/text_lesson_card.dart';
import 'package:studio_reservation_app/components/text_lesson_card_with_route.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/views/splash_screen.dart';
import 'package:studio_reservation_app/views/upcoming_reservation_list_view.dart';

import '../components/colored_button_with_size.dart';
import '../components/upcoming_lesson_card.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../viewmodels/home_screen_view_model.dart';
import '../viewmodels/home_view_model.dart';
import 'lesson_detail_page.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await HomeScreenViewModel().checkInLessonDetails();
      setState(() {});
    });
  }

  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
      viewModel: HomeScreenViewModel(),
      onModelReady: (HomeScreenViewModel model) {},
      onPageBuilder: (BuildContext context, HomeScreenViewModel viewModel) =>
          FutureBuilder(
              future: HomeViewModel().memberDetails(userId!),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello ${snapshot.data.name}, welcome to ${snapshot.data.location}.",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 16),
                                ),
                                const Text(
                                  "Let's Get Exercise",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ],
                            ),
                            const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder(
                        future: HomeScreenViewModel().checkInLessonDetails(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data != null) {
                            return (Column(children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Next Lesson",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      )),
                                ),
                              ),
                              // Divider(
                              //   color: Colors.white.withOpacity(0.7),
                              //   thickness: 1,
                              //   indent: 20,
                              //   endIndent: 20,
                              // ),
                              GestureDetector(
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LessonDetailPage(
                                            lesson_id: snapshot.data.lesson.id,
                                            lesson_date: snapshot
                                                .data.lesson.startDate
                                                .toString(),
                                            lesson_time: snapshot
                                                .data.lesson.estimatedTime
                                                .toString(),
                                            lesson_name:
                                                snapshot.data.lesson.name,
                                            lesson_description: snapshot
                                                    .data.lesson.description ??
                                                " ",
                                            lesson_level: snapshot
                                                .data.lesson.lessonLevel
                                                .toString(),
                                            onpressed: () async {
                                              Navigator.pop(context, true);
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ).then((_) {
                                        setState(() {});
                                      }),
                                  child: CheckInLessonCard(
                                      lesson_name: snapshot.data.lesson.name,
                                      lesson_date: snapshot
                                          .data.lesson.startDate
                                          .toString(),
                                      lesson_time: snapshot
                                          .data.lesson.estimatedTime
                                          .toString(),
                                      lesson_description: snapshot
                                          .data.lesson.description
                                          .toString(),
                                      lesson_level: snapshot
                                                  .data.lesson.lessonLevel
                                                  .toString() ==
                                              "1"
                                          ? "Beginner"
                                          : snapshot.data.lesson.lessonLevel
                                                      .toString() ==
                                                  "2"
                                              ? "Intermediate"
                                              : snapshot.data.lesson.lessonLevel
                                                          .toString() ==
                                                      "3"
                                                  ? "Advanced"
                                                  : "All",
                                      lesson_id: snapshot.data.lesson.id,
                                      isChecked: snapshot.data.isCheckin,
                                      buttonBar: ActionButtons(
                                          lessonId: snapshot.data.lesson.id))),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Upcoming Lesson",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      )),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LessonDetailPage(
                                            lesson_id: snapshot.data.lesson.id,
                                            lesson_date: snapshot
                                                .data.lesson.startDate
                                                .toString(),
                                            lesson_time: snapshot
                                                .data.lesson.estimatedTime
                                                .toString(),
                                            lesson_name:
                                                snapshot.data.lesson.name,
                                            lesson_description: snapshot
                                                    .data.lesson.description ??
                                                " ",
                                            lesson_level: snapshot
                                                .data.lesson.lessonLevel
                                                .toString(),
                                            onpressed: () async {
                                              Navigator.pop(context, true);
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ).then((_) {
                                        setState(() {});
                                      }),
                                  child: UpcomingLessonCard(
                                    lesson_name: snapshot.data.lesson.name,
                                    lesson_date: snapshot.data.lesson.startDate
                                        .toString(),
                                    lesson_time: snapshot
                                        .data.lesson.estimatedTime
                                        .toString(),
                                    lesson_description: snapshot
                                        .data.lesson.description
                                        .toString(),
                                    lesson_level: snapshot
                                                .data.lesson.lessonLevel
                                                .toString() ==
                                            "1"
                                        ? "Beginner"
                                        : snapshot.data.lesson.lessonLevel
                                                    .toString() ==
                                                "2"
                                            ? "Intermediate"
                                            : snapshot.data.lesson.lessonLevel
                                                        .toString() ==
                                                    "3"
                                                ? "Advanced"
                                                : "All",
                                    lesson_id: snapshot.data.lesson.id,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UpcomingReservationListView(),
                                        ),
                                      ).then((_) => setState(() {}));
                                    },
                                    detailSetState: () {
                                      setState(() {});
                                    },
                                  ))
                            ]));
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/asset03.png",
                                    height: 400,
                                    width: 400,
                                  ),
                                  const SizedBox(
                                    height: 0,
                                  ),
                                  const Text(
                                    "You haven't enrolled in any lesson yet,\nyou can enroll from the booking page.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      )
                    ],
                  );
                }
                return Container();
              }),
    );
  }
}
