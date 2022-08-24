import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/components/colored_button_with_size.dart';
import 'package:studio_reservation_app/core/base/base_viewmodel.dart';
import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';
import 'package:studio_reservation_app/views/home_screen_view.dart';

import '../views/home_view.dart';

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
      onModelReady: (HomeScreenViewModel model) async {},
      onPageBuilder: (BuildContext context, HomeScreenViewModel viewModel) {
        return FutureBuilder(
            future:
                viewModel.getMemberLessonByLessonAndMemberId(widget.lessonId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done ||
                  snapshot.connectionState == ConnectionState.waiting) {
                if (snapshot.hasData &&
                    snapshot.data.isEnrolled == true &&
                    snapshot.data.isCheckin != true) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ColoredButtonWithSize(
                        height: 50,
                        width: 150,
                        text: "Check In",
                        onPressed: () async {
                          HomeScreenViewModel().CheckIn(widget.lessonId);
                          await viewModel.getMemberLessonByLessonAndMemberId(
                              widget.lessonId);
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ColoredButtonWithSize(
                        height: 50,
                        width: 150,
                        text: "Cancel",
                        onPressed: () async {
                           HomeScreenViewModel().EnrollCancel(widget.lessonId);
                          await viewModel.getMemberLessonByLessonAndMemberId(
                              widget.lessonId);
                          setState(() {});
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasData &&
                    snapshot.data.isEnrolled == true &&
                    snapshot.data.isCheckin == true) {
                  return const Center(
                    child: Text(
                      'Checked In',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              }
              return FutureBuilder(
                future: HomeScreenViewModel().getLessonById(widget.lessonId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.enrollCount < snapshot.data.enrollQuota) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ColoredButtonWithSize(
                            height: 50,
                            width: 150,
                            text: "Enroll",
                            onPressed: () async {
                              await BookingViewModel().Enroll(widget.lessonId);
                              await viewModel
                                  .getMemberLessonByLessonAndMemberId(
                                      widget.lessonId);
                              setState(() {});
                            },
                          ),
                        ],
                      );
                    } else if (snapshot.data.enrollCount ==
                            snapshot.data.enrollQuota &&
                        snapshot.data.waitingQueueCount <
                            snapshot.data.waitingQueueQuota) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColoredButtonWithSize(
                                height: 50,
                                width: 150,
                                text: "Join Waiting Queue",
                                onPressed: () async {
                                  await HomeScreenViewModel()
                                      .addToWaitingQueue(widget.lessonId);
                                  await viewModel
                                      .getMemberLessonByLessonAndMemberId(
                                          widget.lessonId);
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                "${snapshot.data.waitingQueueCount}/${snapshot.data.waitingQueueQuota} people added to waiting list",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'This Lesson is Full',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );

              // return const Center(child: CircularProgressIndicator());
            });
      },
    );
  }
}
