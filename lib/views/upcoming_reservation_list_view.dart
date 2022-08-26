import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/action_buttons.dart';
import 'package:studio_reservation_app/components/checkin_lesson_card.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';
import '../components/background.dart';
import '../core/base/base_viewmodel.dart';

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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 45, 0, 0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 45, 15, 0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Upcoming Lessons",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder(
                        future: viewModel.reservationList(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot != null) {
                                      return CheckInLessonCard(
                                          lesson_name:
                                              snapshot.data[index].lesson.name,
                                          lesson_date: snapshot
                                              .data[index].lesson.startDate
                                              .toString(),
                                          lesson_time: snapshot
                                              .data[index].lesson.estimatedTime
                                              .toString(),
                                          lesson_description: snapshot
                                              .data[index].lesson.description
                                              .toString(),
                                          lesson_level: snapshot.data[index]
                                                      .lesson.lessonLevel
                                                      .toString() ==
                                                  "1"
                                              ? "Beginner"
                                              : snapshot.data[index].lesson.lessonLevel
                                                          .toString() ==
                                                      "2"
                                                  ? "Intermediate"
                                                  : snapshot.data[index].lesson
                                                              .lessonLevel
                                                              .toString() ==
                                                          "3"
                                                      ? "Advanced"
                                                      : "All",
                                          lesson_id: snapshot.data[index].lesson.id,
                                          buttonBar: ActionButtons(lessonId: snapshot.data[index].lesson.id),
                                          isChecked: snapshot.data[index].isCheckin);
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
