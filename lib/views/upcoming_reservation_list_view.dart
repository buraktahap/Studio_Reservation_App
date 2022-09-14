import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/action_buttons.dart';
import 'package:studio_reservation_app/components/upcoming_lesson_cardv2.dart';
import 'package:studio_reservation_app/components/upcoming_lesson_cardv3.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';
import 'package:table_calendar/table_calendar.dart';
import '../core/base/base_viewmodel.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import 'lesson_detail_page.dart';

List<dynamic> upcomingLessons = [];

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

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<dynamic> _getEventsForDay(DateTime day) {
    return upcomingLessons.where((element) {
      return element.lesson.startDate.day == day.day &&
          element.lesson.startDate.month == day.month &&
          element.lesson.startDate.year == day.year;
    }).toList();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      upcomingLessons = (await HomeScreenViewModel().reservationList(null))!;
      setState(() {});
    });
    super.initState();
  }

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
                                                        .data[index]
                                                        .lesson
                                                        .startDate
                                                        .toString(),
                                                    lessonTime: snapshot
                                                        .data[index]
                                                        .lesson
                                                        .estimatedTime
                                                        .toString(),
                                                    lessonName: snapshot
                                                        .data[index]
                                                        .lesson
                                                        .name,
                                                    lessonDescription: snapshot
                                                            .data[index]
                                                            .lesson
                                                            .description ??
                                                        " ",
                                                    lessonLevel: snapshot
                                                        .data[index]
                                                        .lesson
                                                        .lessonLevel
                                                        .toString(),
                                                    onpressed: () async {
                                                      Navigator.pop(
                                                          context, true);
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ).then((_) {
                                                setState(() {});
                                              }),
                                          child: index == 0
                                              ? UpcomingLessonCardV2(
                                                  data: snapshot.data[index])
                                              : UpcomingLessonCardV3(
                                                  data: snapshot.data[index]));
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  });
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/asset03.png",
                                      height: 250,
                                      width: 250,
                                    ),
                                    const SizedBox(
                                      height: 0,
                                    ),
                                    const Text(
                                      "You haven't enrolled in any lesson for this day,\nyou can enroll from the booking page.",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                )));
  }

  Container openCalendar() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.1,
              blurRadius: 10,
              offset: const Offset(5, 5), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      child: Center(
        child: Column(
          children: [
            TableCalendar(
              eventLoader: ((day) {
                return _getEventsForDay(day);
              }),
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
              onPageChanged: (focusedDay) async {
                upcomingLessons =
                    (await HomeScreenViewModel().reservationList(null))!;
                _focusedDay = _focusedDay;
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) async {
                upcomingLessons =
                    (await HomeScreenViewModel().reservationList(null))!;
                setState(() {
                  upcomingLessons;
                  _selectedDay = selectedDay;
                  _focusedDay = _focusedDay;
                });
                upcomingLessons =
                    (await HomeScreenViewModel().reservationList(null))!;
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
