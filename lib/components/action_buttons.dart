import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/components/colored_button_with_size.dart';
import 'package:studio_reservation_app/core/base/base_viewmodel.dart';
import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';

class ActionButtons extends StatefulWidget {
  final int lessonId;
  const ActionButtons({Key? key, required this.lessonId}) : super(key: key);

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: HomeScreenViewModel(),
      onModelReady: (HomeScreenViewModel model) async {
        await model.getMemberLessonByLessonAndMemberId(widget.lessonId);
      },
      onPageBuilder: (BuildContext context, HomeScreenViewModel viewModel) {
        return FutureBuilder(
            future:
                viewModel.getMemberLessonByLessonAndMemberId(widget.lessonId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData &&
                    snapshot.data.lesson.waitingQueueQuota ==
                        snapshot.data.lesson.waitingQueueCount) {
                  return Center(
                    child: Text(
                        '${snapshot.data.lesson.waitingQueueQuota}/${snapshot.data.lesson.waitingQueueQuota}'),
                  );
                } else if (snapshot.hasData &&
                    snapshot.data.isEnrolled != true &&
                    snapshot.data.lesson.enrollCount <
                        snapshot.data.lesson.enrollQuota) {
                  return ColoredButton(
                    text: "Enroll",
                    onPressed: () async {
                      await BookingViewModel().Enroll(widget.lessonId);
                      setState(() {
                        viewModel.getMemberLessonByLessonAndMemberId(
                            widget.lessonId);
                      });
                    },
                  );
                } else if (snapshot.hasData &&
                    snapshot.data.isEnrolled != true &&
                    snapshot.data.lesson.enrollQuota ==
                        snapshot.data.lesson.enrollCount &&
                    snapshot.data.lesson.waitingQueueCount <
                        snapshot.data.lesson.waitingQueueQuota) {
                  return ColoredButton(
                    text: "Join the Waiting Queue",
                    onPressed: () async {
                      await HomeScreenViewModel()
                          .addToWaitingQueue(widget.lessonId);
                      setState(() {
                        viewModel.getMemberLessonByLessonAndMemberId(
                            widget.lessonId);
                      });
                    },
                  );
                } else if (snapshot.hasData &&
                    snapshot.data.isEnrolled == true &&
                    snapshot.data.isCheckIn != true) {
                  return Row(
                    children: [
                      ColoredButtonWithSize(
                        height: 50,
                        width: 150,
                        text: "Check In",
                        onPressed: () async {
                          HomeScreenViewModel().CheckIn(widget.lessonId);
                          setState(() {
                            viewModel.getMemberLessonByLessonAndMemberId(
                                widget.lessonId);
                          });
                        },
                      ),
                      ColoredButtonWithSize(
                        height: 50,
                        width: 150,
                        text: "Cancel",
                        onPressed: () async {
                          await HomeScreenViewModel()
                              .EnrollCancel(widget.lessonId);
                          setState(() {
                            viewModel.getMemberLessonByLessonAndMemberId(
                                widget.lessonId);
                          });
                        },
                      ),
                    ],
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            });
      },
    );
  }
}
