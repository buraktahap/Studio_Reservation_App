import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/colored_button_with_size.dart';
import 'package:studio_reservation_app/core/base/base_viewmodel.dart';
import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';

class ActionButtons extends StatefulWidget {
  final int lessonId;
  final Alignment align;

  const ActionButtons({Key? key, required this.lessonId, required this.align})
      : super(key: key);

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
                      ColoredButtonWithSize(
                        height: 50,
                        width: 150,
                        text: "Cancel",
                        onPressed: () async {
                          await HomeScreenViewModel()
                              .EnrollCancel(widget.lessonId);

                          await viewModel
                              .MemberLessonByMemberAndLessonIdWithIndex(
                                  widget.lessonId);
                          viewModel.reservationList();
                          setState(() {});
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasData &&
                    snapshot.data.isEnrolled == true &&
                    snapshot.data.isCheckin == true) {
                  return  Align(
                    alignment: widget.align,
                    child: Text(
                      'Checked In',
                      style: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                  );
                } else if (snapshot.data != null && snapshot.data[1] != 0) {
                  return Text("$snapshot.data[1]");
                }
              }

              return FutureBuilder(
                  future: HomeScreenViewModel()
                      .MemberLessonByMemberAndLessonIdWithIndex(
                          widget.lessonId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data[0].enrollCount <
                          snapshot.data[0].enrollQuota) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColoredButtonWithSize(
                              height: 50,
                              width: 150,
                              text: "Enroll",
                              onPressed: () async {
                                await BookingViewModel()
                                    .Enroll(widget.lessonId);
                                await HomeScreenViewModel()
                                    .getMemberLessonByLessonAndMemberId(
                                        widget.lessonId);
                                setState(() {});
                              },
                            ),
                          ],
                        );
                      } else if (snapshot.data[0].enrollCount ==
                              snapshot.data[0].enrollQuota &&
                          snapshot.data[0].waitingQueueCount ==
                              snapshot.data[0].waitingQueueQuota &&
                          (snapshot.data[1] == 0 || snapshot.data[1] == null)) {
                        return  Align(
                          alignment: widget.align,
                          child: Text(
                            "Full Capacity",
                            style: TextStyle(fontSize: 15, color: Colors.red),
                          ),
                        );
                      } else if (snapshot.data[0].enrollCount ==
                              snapshot.data[0].enrollQuota &&
                          snapshot.data[0].waitingQueueCount <
                              snapshot.data[0].waitingQueueQuota &&
                          (snapshot.data[1] == 0 || snapshot.data[1] == null)) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ColoredButtonWithSize(
                              height: 50,
                              width: 150,
                              text: "Join Waiting Queue",
                              onPressed: () async {
                                await HomeScreenViewModel()
                                    .addToWaitingQueue(widget.lessonId);
                                await HomeScreenViewModel()
                                    .MemberLessonByMemberAndLessonIdWithIndex(
                                        widget.lessonId);
                                setState(() {});
                              },
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "${snapshot.data[0].waitingQueueCount}/${snapshot.data[0].waitingQueueQuota} people added to waiting list",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.data[1] != 0 ||
                          snapshot.data[1] != null) {
                        return  Align(
                          alignment: widget.align,
                          child: Text(
                            "In waiting list",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'else',
                            style: TextStyle(fontSize: 20, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  });

              // return const Center(child: CircularProgressIndicator());
            });
      },
    );
  }
}
