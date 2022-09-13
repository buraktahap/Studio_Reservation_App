import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/action_buttons.dart';
import 'package:studio_reservation_app/components/upcoming_lesson_cardv2.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';
import 'package:table_calendar/table_calendar.dart';
import '../core/base/base_viewmodel.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import 'lesson_detail_page.dart';

class UpcomingReservationListView extends StatefulWidget {
  const UpcomingReservationListView({Key? key}) : super(key: key);

  @override
  State<UpcomingReservationListView> createState() =>
      _UpcomingReservationListViewState();
}

class _UpcomingReservationListViewState
    extends State<UpcomingReservationListView> {
  bool? isRememberme =
      LocaleManager.instance.getBoolValue(PreferencesKeys.isRememberMe);
  List<dynamic> upcomingLessons = [];
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
        viewModel: HomeScreenViewModel(),
        onModelReady: (HomeScreenViewModel model) {},
        onPageBuilder: (BuildContext context, HomeScreenViewModel viewModel) =>
            Scaffold(
                resizeToAvoidBottomInset: true,
                extendBody: true,
                body: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 45, 0, 0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back,
                                      color: Theme.of(context)
                                          .buttonTheme
                                          .colorScheme
                                          ?.onSurface),
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
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                          ],
                        ),
                        openCalendar()
                      ],
                    ),
                    Flexible(
                      flex: 4,
                      child: FutureBuilder(
                          future: viewModel.reservationList(_selectedDay),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data.length != 0) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.data != null) {
                                      upcomingLessons = snapshot.data.toList();
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LessonDetailPage(
                                              lessonId: snapshot
                                                  .data[index].lesson.id,
                                              lessonDate: snapshot
                                                  .data[index].lesson.startDate
                                                  .toString(),
                                              lessonTime: snapshot.data[index]
                                                  .lesson.estimatedTime
                                                  .toString(),
                                              lessonName: snapshot
                                                  .data[index].lesson.name,
                                              lessonDescription: snapshot
                                                      .data[index]
                                                      .lesson
                                                      .description ??
                                                  " ",
                                              lessonLevel: snapshot.data[index]
                                                  .lesson.lessonLevel
                                                  .toString(),
                                              onpressed: () async {
                                                Navigator.pop(context, true);
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ).then((_) {
                                          setState(() {});
                                        }),
                                        child: UpcomingLessonCardV2(
                                            trainerName:
                                                "${snapshot.data[index].lesson.trainer.firstName} ${snapshot.data[index].lesson.trainer.lastName}",
                                            lessonBranch: snapshot
                                                .data[index].lesson.classes
                                                .toString(),
                                            lessonName: snapshot
                                                .data[index].lesson.name,
                                            lessonDate: snapshot
                                                .data[index].lesson.startDate
                                                .toString(),
                                            lessonTime: snapshot.data[index]
                                                .lesson.estimatedTime
                                                .toString(),
                                            lessonDescription: snapshot
                                                .data[index].lesson.description
                                                .toString(),
                                            lessonLevel: snapshot.data[index]
                                                        .lesson.lessonLevel
                                                        .toString() ==
                                                    "0"
                                                ? "Beginner"
                                                : snapshot.data[index].lesson
                                                            .lessonLevel
                                                            .toString() ==
                                                        "1"
                                                    ? "Mid"
                                                    : snapshot.data[index].lesson.lessonLevel.toString() == "2"
                                                        ? "Advanced"
                                                        : "All",
                                            lessonId: snapshot.data[index].lesson.id,
                                            buttonBar: ActionButtons(align: Alignment.centerLeft, lessonId: snapshot.data[index].lesson.id),
                                            isChecked: snapshot.data[index].isCheckin),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  });
                            } else {
                              debugPrint("$isRememberme");
                              return Center(child: Text("No Upcoming Lessons"));
                            }
                          }),
                    ),
                  ],
                )));
  }

  Container openCalendar() {
    // List<dynamic> _getEventsForDay(DateTime day) {
    //   return upcomingLessons;
    // }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      child: Center(
        child: Column(
          children: [
            TableCalendar(
              // eventLoader: ((day) {
              //   return _getEventsForDay(day);
              // }),
              calendarStyle: const CalendarStyle(
                  rangeHighlightColor: Colors.black,
                  selectedTextStyle: TextStyle(color: Colors.white),
                  todayTextStyle: TextStyle(color: Colors.black),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment(0.9999982118745121, 0.999980688244732),
                      end: Alignment(0.9999982118745121, -1.0000038146677073),
                      stops: [0.0, 1.0],
                      colors: [
                        Color.fromRGBO(235, 12, 146, 0.3),
                        Color.fromRGBO(255, 170, 146, 0.3)
                      ],
                    ),
                  ),
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment(0.9999982118745121, 0.999980688244732),
                      end: Alignment(0.9999982118745121, -1.0000038146677073),
                      stops: [0.0, 1.0],
                      colors: [
                        Color.fromARGB(255, 253, 12, 146),
                        Color.fromARGB(255, 255, 170, 146)
                      ],
                    ),
                  )),
              rowHeight: 35,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _selectedDay,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                titleTextStyle: TextStyle(color: Colors.purple),
                formatButtonShowsNext: false,
                formatButtonTextStyle: TextStyle(color: Colors.lightBlue),
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  debugPrint(selectedDay.toString());
                  _selectedDay = selectedDay;
                  _focusedDay =
                      selectedDay; // update `_focusedDay` here as well
                });
              },
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     TextButton(
            //         onPressed: () {
            //           setState(() {
            //             _selectedDay = DateTime.now();
            //           });
            //         },
            //         child: const Text(
            //           "Bugün",
            //           style: TextStyle(color: Colors.purple),
            //         )),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
