import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/classes/member.dart';
import 'package:studio_reservation_app/components/checked_lesson_card.dart';
import 'package:studio_reservation_app/components/checkin_lesson_card.dart';
import 'package:studio_reservation_app/components/enroll_lesson_card.dart';
import 'package:studio_reservation_app/components/text_lesson_card.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/models/member_location_update_response.dart';
import 'package:studio_reservation_app/static_member.dart';
import 'package:studio_reservation_app/views/home_view.dart';

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
              future: HomeScreenViewModel().checkInLessonJoined(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null || snapshot.data[0] == null) {
                  return const TextLessonCard(
                      text:
                          "You have nothing to checkin. You can enroll more lesson from the booking page!");
                } else if (snapshot.data[0] != null &&
                    snapshot.data[0].isCheckin == true) {
                  return CheckedLessonCard(
                    lesson_name: snapshot.data[1].name,
                    lesson_date: snapshot.data[1].startDate,
                    lesson_time: snapshot.data[1].estimatedTime,
                    lesson_description: snapshot.data[1].description.toString(),
                    lesson_level: snapshot.data[1].lessonLevel.toString() == "1"
                        ? "Beginner"
                        : snapshot.data[0].lessonLevel.toString() == "2"
                            ? "Intermediate"
                            : snapshot.data[0].lessonLevel.toString() == "3"
                                ? "Advanced"
                                : "All",
                    lesson_id: snapshot.data[1].id,
                    text: "You have succesfully checked in!",
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data[0] != null &&
                    snapshot.data[1].id != null &&
                    snapshot.data[0].isCheckin != true) {
                  var lesson = viewModel.checkInLesson();
                  print(viewModel.isCheckin);
                  return CheckInLessonCard(
                    lesson_name: snapshot.data[1].name,
                    lesson_date: snapshot.data[1].startDate,
                    lesson_time: snapshot.data[1].estimatedTime,
                    lesson_description: snapshot.data[1].description.toString(),
                    lesson_level: snapshot.data[1].lessonLevel.toString() == "1"
                        ? "Beginner"
                        : snapshot.data[0].lessonLevel.toString() == "2"
                            ? "Intermediate"
                            : snapshot.data[0].lessonLevel.toString() == "3"
                                ? "Advanced"
                                : "All",
                    lesson_id: snapshot.data[1].id,
                  );
                }
                return Container();
              }),
          FutureBuilder(
              future: HomeScreenViewModel().reservationList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null &&
                    snapshot.data.length > 0) {
                  return UpcomingLessonCard(
                    lesson_name: snapshot.data[0].name,
                    lesson_date: snapshot.data[0].startDate,
                    lesson_time: snapshot.data[0].estimatedTime,
                    lesson_description: snapshot.data[0].description.toString(),
                    lesson_level: snapshot.data[0].lessonLevel.toString() == "1"
                        ? "Beginner"
                        : snapshot.data[0].lessonLevel.toString() == "2"
                            ? "Intermediate"
                            : snapshot.data[0].lessonLevel.toString() == "3"
                                ? "Advanced"
                                : "All",
                    lesson_id: snapshot.data[0].id,
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
