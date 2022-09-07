import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:studio_reservation_app/components/action_buttons.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/core/base/base_viewmodel.dart';
import '../viewmodels/home_screen_view_model.dart';

Widget waitingList = Container();

class LessonDetailPage extends StatefulWidget {
  final String lessonName;
  final String lessonDate;
  final String lessonDescription;
  final int lessonId;
  // final String lesson_image;
  final String lessonLevel;
  final String lessonTime;

  final VoidCallback onpressed;

  const LessonDetailPage({
    Key? key,
    required this.lessonName,
    required this.lessonDescription,
    required this.lessonId,
    required this.lessonLevel,
    required this.lessonTime,
    required this.lessonDate,
    required this.onpressed,
  }) : super(key: key);

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  FutureBuilder<List> waitingListWidget() {
    return FutureBuilder(
        initialData: [waitingList],
        future: HomeScreenViewModel()
            .memberLessonByMemberAndLessonIdWithIndex(widget.lessonId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data[1] != null &&
              snapshot.data[1] != 0) {
            waitingList = Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "You are on the ${snapshot.data[1]}. place in the waiting list. ",
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            );
            return waitingList;
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data[0] != null &&
              snapshot.data[1] == null &&
              snapshot.data[0].enrollCount == snapshot.data[0].enrollQuota &&
              snapshot.data[0].waitingQueueCount !=
                  snapshot.data[0].waitingQueueQuota) {
            waitingList = Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${snapshot.data[0].waitingQueueCount}/${snapshot.data[0].waitingQueueQuota} people added to waiting list",
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
            );
            return waitingList;
          } else {
            return Container();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
        viewModel: HomeScreenViewModel(),
        onModelReady: (HomeScreenViewModel model) async {
          await HomeScreenViewModel().getLessonById(widget.lessonId);
        },
        onPageBuilder: (BuildContext context, HomeScreenViewModel viewModel) =>
            Scaffold(
                extendBody: true,
                extendBodyBehindAppBar: true,
                body: Background(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                          child: FutureBuilder(
                              future: viewModel.getLessonById(widget.lessonId),
                              initialData:
                                  viewModel.getLessonById(widget.lessonId),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy')
                                          .format(snapshot.data.startDate)
                                          .toString();
                                  final String formattedTime =
                                      DateFormat('HH:mm')
                                          .format(snapshot.data.startDate)
                                          .toString();

                                  final String duration = DateFormat('HH:mm')
                                      .format(snapshot.data.estimatedTime)
                                      .toString();

                                  return Stack(
                                    children: [
                                      Image.asset('assets/images/asset01.png'),
                                      IconButton(
                                        icon: Icon(Icons.arrow_back,
                                            color: Theme.of(context)
                                                .buttonTheme
                                                .colorScheme
                                                ?.onSurface),
                                        onPressed: widget.onpressed,
                                      ),
                                      DraggableScrollableSheet(
                                        initialChildSize: 0.55,
                                        minChildSize: 0.5,
                                        maxChildSize: 1,
                                        builder: (context, scrollController) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(30),
                                                      topRight:
                                                          Radius.circular(30)),
                                              gradient: LinearGradient(
                                                begin: const Alignment(
                                                    0.9999982118745121,
                                                    0.999980688244732),
                                                end: const Alignment(
                                                    0.9999982118745121,
                                                    -1.0000038146677073),
                                                stops: const [0.75, 1.0],
                                                colors: [
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  const Color(0xffFF89B6)
                                                ],
                                              ),
                                            ),
                                            child: SingleChildScrollView(
                                                controller: scrollController,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          30, 25, 30, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          snapshot.data.name,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      snapshot.data.rate != 0
                                                          ? ratingBar(
                                                              snapshot, 13)
                                                          : const SizedBox(
                                                              height: 0,
                                                            ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          snapshot.data.classes
                                                              .name,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                        width: double.infinity,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          snapshot.data
                                                                  .description ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          DetailWithIcon(
                                                              icon:
                                                                  "assets/images/date.png",
                                                              iconDescription:
                                                                  "Date ",
                                                              iconStatus:
                                                                  formattedDate),
                                                          DetailWithIcon(
                                                              icon:
                                                                  "assets/images/startDate.png",
                                                              iconDescription:
                                                                  "Start Time",
                                                              iconStatus:
                                                                  formattedTime),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          DetailWithIcon(
                                                            icon:
                                                                "assets/images/level2.png",
                                                            iconDescription:
                                                                "Level",
                                                            iconStatus: snapshot
                                                                        .data
                                                                        .lessonLevel ==
                                                                    "0"
                                                                ? "Beginner"
                                                                : snapshot.data
                                                                            .lessonLevel
                                                                            .toString() ==
                                                                        "1"
                                                                    ? "Mid"
                                                                    : snapshot.data.lessonLevel.toString() ==
                                                                            "2"
                                                                        ? "Advanced"
                                                                        : "All",
                                                          ),
                                                          DetailWithIcon(
                                                              icon:
                                                                  "assets/images/duration.png",
                                                              iconDescription:
                                                                  "Duration",
                                                              iconStatus:
                                                                  duration),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Divider(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.1),
                                                        thickness: 1,
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                                backgroundImage:
                                                                    Image.asset(
                                                                            'assets/images/trainer1.png')
                                                                        .image,
                                                                radius: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.06),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              snapshot
                                                                      .data
                                                                      .trainer
                                                                      .firstName +
                                                                  " " +
                                                                  snapshot
                                                                      .data
                                                                      .trainer
                                                                      .lastName,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          22),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      waitingListWidget(),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: double.infinity,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: const Offset(0,
                                                    0), // changes position of shadow
                                              ),
                                            ],
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 20, 0),
                                              child: ActionButtons(
                                                  align: Alignment.center,
                                                  lessonId: widget.lessonId),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // ...
                                    ],
                                  );
                                } else {
                                  return const Align(
                                      alignment: Alignment.bottomCenter,
                                      child: CircularProgressIndicator());
                                }
                              })),
                    ),
                  ],
                ))));
  }

  Row ratingBar(AsyncSnapshot<dynamic> snapshot, int size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RatingBarIndicator(
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          rating:
              snapshot.data.rate == null ? 0 : snapshot.data.rate.toDouble(),
          itemCount: 5,
          itemSize: size.toDouble(),
          direction: Axis.horizontal,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          snapshot.data.rate.toString().substring(0, 3),
          style: TextStyle(fontSize: size.toDouble()),
        ),
      ],
    );
  }
}

class DetailWithIcon extends StatelessWidget {
  final String icon;

  final String iconDescription;

  final String iconStatus;

  const DetailWithIcon({
    Key? key,
    required this.icon,
    required this.iconDescription,
    required this.iconStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 40,
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  iconDescription,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  iconStatus,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
