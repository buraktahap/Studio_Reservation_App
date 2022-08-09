import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/components/checkin_lesson_card.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';

import '../components/background.dart';
import '../core/base/base_viewmodel.dart';
import '../viewmodels/booking_view_model.dart';

class UpcomingReservationListView extends StatefulWidget {
  const UpcomingReservationListView({Key? key}) : super(key: key);

  @override
  State<UpcomingReservationListView> createState() =>
      _UpcomingReservationListViewState();
}

class _UpcomingReservationListViewState
    extends State<UpcomingReservationListView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
        viewModel: HomeScreenViewModel(),
        onModelReady: (HomeScreenViewModel model) {},
        onPageBuilder: (BuildContext context, HomeScreenViewModel viewModel) =>
            Scaffold(
                extendBody: true,
                body: Background(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 45, 15, 0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Upcoming Lessons",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: viewModel.reservationList(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot != null) {
                                      return CheckInLessonCard(
                                        lesson_name: snapshot.data[index].name,
                                        lesson_date:
                                            snapshot.data[index].startDate,
                                        lesson_time:
                                            snapshot.data[index].estimatedTime,
                                        lesson_description: snapshot
                                            .data[index].description
                                            .toString(),
                                        lesson_level: snapshot
                                            .data[index].lessonLevel
                                            .toString(),
                                        lesson_id: snapshot.data[index].id,
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  }),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ],
                ))));
  }
}
