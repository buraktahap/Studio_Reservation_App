import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/components/upcoming_lesson_Card.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/core/enums/url_enum.dart';
import 'package:studio_reservation_app/models/member_location_update_response.dart';
import 'package:studio_reservation_app/models/sign_in_response.dart';
import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';
import 'package:studio_reservation_app/viewmodels/location_selection_view_model.dart';

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

  @override
  Widget build(BuildContext context) {
    LocationSelectionView locationViewModel = LocationSelectionView();
    return BaseView<BookingViewModel>(
        viewModel: BookingViewModel(),
        onModelReady: (BookingViewModel model) {},
        onPageBuilder: (BuildContext context, BookingViewModel model) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 45, 15, 0),
                    child: Text(
                      userLocation!,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  onLongPressEnd: (details) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationSelectionView(),
                      ),
                    );
                  },
                ),

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
                                return UpcomingLessonCard(
                                  lesson_name: snapshot.data[index].name,
                                  lesson_date: snapshot.data[index].startDate,
                                  lesson_time:
                                      snapshot.data[index].estimatedTime,
                                  lesson_description: snapshot
                                      .data[index].description
                                      .toString(),
                                  // lesson_image: snapshot.data[index].image,
                                  lesson_level: snapshot.data[index].lessonLevel
                                      .toString(),
                                );
                              }),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                // ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: viewModel.lessons.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Padding(
                //         padding: const EdgeInsets.all(15.0),
                //         child: Container(
                //           color: Colors.blue,
                //           margin: EdgeInsets.all(10),
                //           padding: EdgeInsets.all(15),
                //           alignment: Alignment.center,
                //           child: Text(
                //             viewModel.lessons[index].name,
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 22,
                //             ),
                //           ),
                //         ),
                //       );
                //     }),
              ],
            ));
  }
}
