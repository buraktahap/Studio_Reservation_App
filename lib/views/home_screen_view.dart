import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/classes/member.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/checked_lesson_card.dart';
import 'package:studio_reservation_app/components/checkin_lesson_card.dart';
import 'package:studio_reservation_app/components/enroll_lesson_card.dart';
import 'package:studio_reservation_app/components/text_lesson_card.dart';
import 'package:studio_reservation_app/components/text_lesson_card_with_route.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/models/member_location_update_response.dart';
import 'package:studio_reservation_app/static_member.dart';
import 'package:studio_reservation_app/views/booking_view.dart';
import 'package:studio_reservation_app/views/home_view.dart';
import 'package:studio_reservation_app/views/upcoming_reservation_list_view.dart';

import '../components/colored_button_with_size.dart';
import '../components/upcoming_lesson_card.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../viewmodels/home_screen_view_model.dart';
import '../viewmodels/home_view_model.dart';

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
          ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                FutureBuilder(
                    future: HomeViewModel().memberDetails(userId!),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Expanded(
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
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
          FutureBuilder(
              future: HomeScreenViewModel().checkInLessonDetails(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null || snapshot.data.lesson == null) {
                  return TextLessonCardWithRoute(
                    text: Text.rich(
                      TextSpan(
                          text:
                              "You haven't joined any lesson yet. You can join a lesson by clicking the button below.",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ),
                  );
                } else if (snapshot.data != null &&
                    snapshot.data.isCheckin == true) {
                  return CheckedLessonCard(
                    lesson_name: snapshot.data.lesson.name,
                    lesson_date: snapshot.data.lesson.startDate.toString(),
                    lesson_time: snapshot.data.lesson.estimatedTime.toString(),
                    lesson_description:
                        snapshot.data.lesson.description.toString(),
                    lesson_level: snapshot.data.lesson.lessonLevel.toString() ==
                            "1"
                        ? "Beginner"
                        : snapshot.data.lesson.lessonLevel.toString() == "2"
                            ? "Intermediate"
                            : snapshot.data.lesson.lessonLevel.toString() == "3"
                                ? "Advanced"
                                : "All",
                    lesson_id: snapshot.data.lesson.id,
                    text: "You have succesfully checked in!",
                    isChecked: snapshot.data.isCheckin,
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null &&
                    snapshot.data.lesson.id != null &&
                    snapshot.data.isCheckin != true) {
                  print(viewModel.isCheckin);
                  return CheckInLessonCard(
                    lesson_name: snapshot.data.lesson.name,
                    lesson_date: snapshot.data.lesson.startDate.toString(),
                    lesson_time: snapshot.data.lesson.estimatedTime.toString(),
                    lesson_description:
                        snapshot.data.lesson.description.toString(),
                    lesson_level: snapshot.data.lesson.lessonLevel.toString() ==
                            "1"
                        ? "Beginner"
                        : snapshot.data.lesson.lessonLevel.toString() == "2"
                            ? "Intermediate"
                            : snapshot.data.lesson.lessonLevel.toString() == "3"
                                ? "Advanced"
                                : "All",
                    lesson_id: snapshot.data.lesson.id,
                    isChecked: snapshot.data.isCheckin,
                    buttonBar: snapshot.data.isCheckin == true
                        ? const Text("You have succesfully checked in!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ))
                        : ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ColoredButtonWithSize(
                                    text: "Check In",
                                    // onPressed: viewModel.Enroll(memberId, widget.lesson_id),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 45,
                                    onPressed: () async {
                                      viewModel.CheckIn(snapshot.data.lessonId);
                                      print(viewModel.isCheckin);
                                      await viewModel.reservationList();
                                      setState(() {});
                                    },
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ColoredButtonWithSize(
                                    text: "Cancel",
                                    // onPressed: viewModel.Enroll(memberId, widget.lesson_id),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 45,
                                    onPressed: () async {
                                      viewModel.EnrollCancel(
                                          snapshot.data.lessonId);
                                      await viewModel.reservationList();
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                  );
                }
                return Container();
              }),
          FutureBuilder(
              future: HomeScreenViewModel().checkInLessonDetails(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  return UpcomingLessonCard(
                    lesson_name: snapshot.data.lesson.name,
                    lesson_date: snapshot.data.lesson.startDate.toString(),
                    lesson_time: snapshot.data.lesson.estimatedTime.toString(),
                    lesson_description:
                        snapshot.data.lesson.description.toString(),
                    lesson_level: snapshot.data.lesson.lessonLevel.toString() ==
                            "1"
                        ? "Beginner"
                        : snapshot.data.lesson.lessonLevel.toString() == "2"
                            ? "Intermediate"
                            : snapshot.data.lesson.lessonLevel.toString() == "3"
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
                  );
                } else {
                  return const TextLessonCard(
                      text:
                          "You have no upcoming lesson. You can enroll more lesson from the booking page!");
                }
              })
        ],
      ),
    );
  }
}
