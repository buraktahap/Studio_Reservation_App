import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:studio_reservation_app/components/completed_lesson_card.dart';
import 'package:studio_reservation_app/components/text_lesson_card.dart';
import 'package:studio_reservation_app/core/base/base_viewmodel.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';
import 'package:studio_reservation_app/viewmodels/home_view_model.dart';
import 'package:studio_reservation_app/views/completed_lessons_list.dart';
import 'package:studio_reservation_app/views/ungraded_lessons.dart';
import 'package:studio_reservation_app/views/upcoming_reservation_list_view.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import 'lesson_detail_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.userId);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: HomeViewModel(),
      onModelReady: (HomeViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, HomeViewModel viewModel) =>
          SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 45, 20, 80),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FutureBuilder(
                    future: HomeViewModel().memberDetails(userId!),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Stack(alignment: Alignment.center, children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xffFF3E85),
                                      width: 3,
                                    ),
                                  ),
                                ),
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage("assets/images/trainer1.png"),
                                ),
                              ]),
                              const SizedBox(height: 20),
                              Text(
                                snapshot.data!.name +
                                    " " +
                                    snapshot.data!.surname,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Member Type : ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                      snapshot.data!.memberType == 1
                                          ? "Online"
                                          : "Onsite",
                                      style: const TextStyle(
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Subscription Type: ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                      snapshot.data!.subscriptions.subsType == 0
                                          ? "3 Months"
                                          : snapshot.data!.subscriptions
                                                      .subsType ==
                                                  1
                                              ? "6 Months"
                                              : "12 Months",
                                      style: const TextStyle(
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Subscription Expire Date:",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(DateFormat('dd-MM-yyyy  HH:mm').format(
                                      DateTime.parse(snapshot
                                          .data.subscriptions.endDate
                                          .toString()))),
                                ],
                              )
                            ],
                          );
                        }
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: HomeScreenViewModel()
                          .getCompletedLessonCount(userId!),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Completed Lesson Count : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                  snapshot.hasData
                                      ? snapshot.data.toString()
                                      : "0",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  )),
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: HomeScreenViewModel().getUngradedLessons(userId!),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return ExpansionTile(
                                tilePadding: const EdgeInsets.all(0),
                                collapsedTextColor:
                                    Theme.of(context).colorScheme.secondary,
                                textColor:
                                    Theme.of(context).colorScheme.secondary,
                                title: const Text(
                                  "Ungraded Lessons",
                                ),
                                children: [
                                  ListView.builder(
                                      padding: const EdgeInsets.all(0),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length >= 3
                                          ? 3
                                          : snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LessonDetailPage(
                                                      lessonId: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .id,
                                                      lessonDate: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .startDate
                                                          .toString(),
                                                      lessonTime: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .estimatedTime
                                                          .toString(),
                                                      lessonName: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .name,
                                                      lessonDescription: snapshot
                                                              .data[index]
                                                              .lesson
                                                              .description ??
                                                          " ",
                                                      lessonLevel: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .lessonLevel
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
                                            child: CompletedLessonCard(
                                              data: snapshot.data[index],
                                            ));
                                      }),
                                  snapshot.data.length != 0
                                      ? TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const UngradedLessons(),
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
                                        )
                                      : const SizedBox(),
                                ]);
                          } else {
                            return const TextLessonCard(
                                text: "No ungraded lessons");
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                  FutureBuilder(
                      future: HomeScreenViewModel().reservationList(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return ExpansionTile(
                                tilePadding: const EdgeInsets.all(0),
                                collapsedTextColor:
                                    Theme.of(context).colorScheme.secondary,
                                textColor:
                                    Theme.of(context).colorScheme.secondary,
                                title: const Text("Upcoming Lessons"),
                                children: [
                                  ListView.builder(
                                      padding: const EdgeInsets.all(0),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length >= 3
                                          ? 3
                                          : snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LessonDetailPage(
                                                      lessonId: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .id,
                                                      lessonDate: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .startDate
                                                          .toString(),
                                                      lessonTime: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .estimatedTime
                                                          .toString(),
                                                      lessonName: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .name,
                                                      lessonDescription: snapshot
                                                              .data[index]
                                                              .lesson
                                                              .description ??
                                                          " ",
                                                      lessonLevel: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .lessonLevel
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
                                            child: CompletedLessonCard(
                                                data: snapshot.data[index]));
                                      }),
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
                                          color:
                                              Color.fromARGB(255, 253, 12, 146),
                                          fontSize: 16),
                                    ),
                                  ),
                                ]);
                          } else {
                            return const TextLessonCard(
                                text: "No active reservations");
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                  FutureBuilder(
                      future:
                          HomeScreenViewModel().getCompletedLessons(userId!),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return ExpansionTile(
                                tilePadding: const EdgeInsets.all(0),
                                collapsedTextColor:
                                    Theme.of(context).colorScheme.secondary,
                                textColor:
                                    Theme.of(context).colorScheme.secondary,
                                title: const Text("Completed Lessons"),
                                children: [
                                  ListView.builder(
                                      padding: const EdgeInsets.all(0),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length >= 3
                                          ? 3
                                          : snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LessonDetailPage(
                                                      lessonId: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .id,
                                                      lessonDate: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .startDate
                                                          .toString(),
                                                      lessonTime: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .estimatedTime
                                                          .toString(),
                                                      lessonName: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .name,
                                                      lessonDescription: snapshot
                                                              .data[index]
                                                              .lesson
                                                              .description ??
                                                          " ",
                                                      lessonLevel: snapshot
                                                          .data[index]
                                                          .lesson
                                                          .lessonLevel
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
                                            child: CompletedLessonCard(
                                                data: snapshot.data[index],
                                                buttonBar: RatingBarIndicator(
                                                  itemBuilder:
                                                      (context, index) =>
                                                          const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  rating: snapshot
                                                          .data[index].rate ??
                                                      0,
                                                  itemCount: 5,
                                                  itemSize: 20.0,
                                                  direction: Axis.horizontal,
                                                )));
                                      }),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CompletedLessonsList(),
                                        ),
                                      ).then((_) => setState(() {}));
                                    },
                                    child: const Text(
                                      "See All",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 253, 12, 146),
                                          fontSize: 16),
                                    ),
                                  ),
                                ]);
                          } else {
                            return const TextLessonCard(
                                text: "No completed lessons");
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}
