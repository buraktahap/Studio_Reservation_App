import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/components/enroll_lesson_Card.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/core/enums/url_enum.dart';
import 'package:studio_reservation_app/models/member_location_update_response.dart';
import 'package:studio_reservation_app/models/sign_in_response.dart';
import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';
import 'package:studio_reservation_app/viewmodels/home_view_model.dart';
import 'package:studio_reservation_app/viewmodels/location_selection_view_model.dart';

import '../components/colored_button_with_size.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import 'location_selection_view.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final String? userLocation =
      LocaleManager.instance.getStringValue(PreferencesKeys.USER_LOCATION);
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);
  @override
  Widget build(BuildContext context) {
    return BaseView<BookingViewModel>(
        viewModel: BookingViewModel(),
        onModelReady: (BookingViewModel model) {},
        onPageBuilder: (BuildContext context, BookingViewModel model) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 45, 15, 0),
                      child: Row(
                        children: [
                          Text(
                            userLocation!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                          const Icon(Icons.arrow_drop_down,
                              color: Colors.white),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationSelectionView(),
                        ),
                      );
                    }),
                FutureBuilder(
                    future:
                        BookingViewModel().LessonsByBranchName(userLocation),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return EnrollLessonCard(
                                  lesson_name: snapshot.data[index].name,
                                  lesson_date:
                                      snapshot.data[index].startDate.toString(),
                                  lesson_time: snapshot
                                      .data[index].estimatedTime
                                      .toString(),
                                  lesson_description: snapshot
                                      .data[index].description
                                      .toString(),
                                  lesson_level: snapshot.data[index].lessonLevel
                                              .toString() ==
                                          "1"
                                      ? "Beginner"
                                      : snapshot.data[0].lessonLevel
                                                  .toString() ==
                                              "2"
                                          ? "Intermediate"
                                          : snapshot.data[0].lessonLevel
                                                      .toString() ==
                                                  "3"
                                              ? "Advanced"
                                              : "All",
                                  lesson_id: snapshot.data[index].id,
                                  isEnrolled: snapshot.data[index].isEnrolled,
                                  location: userLocation,
                                  buttonOrText:
                                      snapshot.data[index].isEnrolled == false
                                          ? ColoredButtonWithSize(
                                              text: "Enroll",
                                              onPressed: () async {
                                                BookingViewModel().Enroll(
                                                    userId!,
                                                    snapshot.data[index].id);
                                                await BookingViewModel()
                                                    .LessonsByBranchName(
                                                        userLocation);
                                                setState(() {});
                                              },
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              height: 45)
                                          : const Text(
                                              ('You have already enrolled for this lesson!'),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                );
                              }),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            ));
  }
}
