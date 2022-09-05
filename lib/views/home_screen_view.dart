import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/action_buttons.dart';
import 'package:studio_reservation_app/components/checkin_lesson_card.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/views/upcoming_reservation_list_view.dart';
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
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Text(
                                  "Let's Get Exercise",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                            const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.notifications,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: FutureBuilder(
                              future:
                                  HomeScreenViewModel().checkInLessonDetails(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.data != null) {
                                  return (Column(children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Next Lesson",
                                            style: TextStyle(
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
                                                  lesson_id:
                                                      snapshot.data.lesson.id,
                                                  lesson_date: snapshot
                                                      .data.lesson.startDate
                                                      .toString(),
                                                  lesson_time: snapshot
                                                      .data.lesson.estimatedTime
                                                      .toString(),
                                                  lesson_name:
                                                      snapshot.data.lesson.name,
                                                  lesson_description: snapshot
                                                          .data
                                                          .lesson
                                                          .description ??
                                                      " ",
                                                  lesson_level: snapshot
                                                      .data.lesson.lessonLevel
                                                      .toString(),
                                                  onpressed: () async {
                                                    Navigator.pop(
                                                        context, true);
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ).then((_) {
                                              setState(() {});
                                            }),
                                        child: CheckInLessonCard(
                                            lesson_name:
                                                snapshot.data.lesson.name,
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
                                                : snapshot.data.lesson
                                                            .lessonLevel
                                                            .toString() ==
                                                        "2"
                                                    ? "Intermediate"
                                                    : snapshot.data.lesson
                                                                .lessonLevel
                                                                .toString() ==
                                                            "3"
                                                        ? "Advanced"
                                                        : "All",
                                            lesson_id: snapshot.data.lesson.id,
                                            isChecked: snapshot.data.isCheckin,
                                            buttonBar: ActionButtons(
                                                align: Alignment.centerLeft,
                                                lessonId:
                                                    snapshot.data.lesson.id))),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Upcoming Lesson",
                                              style: TextStyle(
                                                fontSize: 22,
                                              )),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const UpcomingReservationListView(),
                                                ),
                                              ).then((_) => setState(() {}));
                                            },
                                            child: const Text(
                                              "See All",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 253, 12, 146),
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LessonDetailPage(
                                                  lesson_id:
                                                      snapshot.data.lesson.id,
                                                  lesson_date: snapshot
                                                      .data.lesson.startDate
                                                      .toString(),
                                                  lesson_time: snapshot
                                                      .data.lesson.estimatedTime
                                                      .toString(),
                                                  lesson_name:
                                                      snapshot.data.lesson.name,
                                                  lesson_description: snapshot
                                                          .data
                                                          .lesson
                                                          .description ??
                                                      " ",
                                                  lesson_level: snapshot
                                                      .data.lesson.lessonLevel
                                                      .toString(),
                                                  onpressed: () async {
                                                    Navigator.pop(
                                                        context, true);
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ).then((_) {
                                              setState(() {});
                                            }),
                                        child: UpcomingLessonCard(
                                          lesson_name:
                                              snapshot.data.lesson.name,
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
                                                  : snapshot.data.lesson
                                                              .lessonLevel
                                                              .toString() ==
                                                          "3"
                                                      ? "Advanced"
                                                      : "All",
                                          lesson_id: snapshot.data.lesson.id,
                                          detailSetState: () {
                                            setState(() {});
                                          },
                                        )),

                                    FutureBuilder(
                                        future: HomeScreenViewModel()
                                            .getCompletedLessons(userId!),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.data != null) {
                                            return Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 0, 20, 0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text("Your Last Visit",
                                                            style: TextStyle(
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
                                                              lesson_id:
                                                                  snapshot
                                                                      .data[0]
                                                                      .lesson
                                                                      .id,
                                                              lesson_date:
                                                                  snapshot
                                                                      .data[0]
                                                                      .lesson
                                                                      .startDate
                                                                      .toString(),
                                                              lesson_time: snapshot
                                                                  .data[0]
                                                                  .lesson
                                                                  .estimatedTime
                                                                  .toString(),
                                                              lesson_name:
                                                                  snapshot
                                                                      .data[0]
                                                                      .lesson
                                                                      .name,
                                                              lesson_description:
                                                                  snapshot
                                                                          .data[
                                                                              0]
                                                                          .lesson
                                                                          .description ??
                                                                      " ",
                                                              lesson_level: snapshot
                                                                  .data[0]
                                                                  .lesson
                                                                  .lessonLevel
                                                                  .toString(),
                                                              onpressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context,
                                                                    true);
                                                                setState(() {});
                                                              },
                                                            ),
                                                          ),
                                                        ).then((_) {
                                                          setState(() {});
                                                        }),
                                                    child: CheckInLessonCard(
                                                      lesson_name: snapshot
                                                          .data[0].lesson.name,
                                                      lesson_date: snapshot
                                                          .data[0]
                                                          .lesson
                                                          .startDate
                                                          .toString(),
                                                      lesson_time: snapshot
                                                          .data[0]
                                                          .lesson
                                                          .estimatedTime
                                                          .toString(),
                                                      lesson_description:
                                                          snapshot
                                                              .data[0]
                                                              .lesson
                                                              .description
                                                              .toString(),
                                                      lesson_level: snapshot
                                                                  .data[0]
                                                                  .lesson
                                                                  .lessonLevel
                                                                  .toString() ==
                                                              "1"
                                                          ? "Beginner"
                                                          : snapshot
                                                                      .data[0]
                                                                      .lesson
                                                                      .lessonLevel
                                                                      .toString() ==
                                                                  "2"
                                                              ? "Intermediate"
                                                              : snapshot
                                                                          .data[
                                                                              0]
                                                                          .lesson
                                                                          .lessonLevel
                                                                          .toString() ==
                                                                      "3"
                                                                  ? "Advanced"
                                                                  : "All",
                                                      lesson_id: snapshot
                                                          .data[0].lesson.id,
                                                      isChecked: snapshot
                                                          .data[0].isCheckin,
                                                      buttonBar: ActionButtons(
                                                          lessonId: snapshot
                                                              .data[0].lessonId,
                                                          align: Alignment
                                                              .centerLeft),
                                                    )),
                                              ],
                                            );
                                          } else if (snapshot.hasData ==
                                              false) {
                                            return Center(
                                              child: Container(),
                                            );
                                          } else {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        }),
                                  ]));
                                } else if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.data == null) {
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
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
                return Container();
              }),
    );
  }
}
