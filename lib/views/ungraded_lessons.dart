import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:studio_reservation_app/components/action_buttons.dart';
import 'package:studio_reservation_app/components/checkin_lesson_card.dart';
import 'package:studio_reservation_app/components/completed_lesson_card.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';
import '../components/background.dart';
import '../core/base/base_viewmodel.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import 'lesson_detail_page.dart';

class UngradedLessons extends StatefulWidget {
  const UngradedLessons({Key? key}) : super(key: key);

  @override
  State<UngradedLessons> createState() => _UngradedLessonsState();
}

class _UngradedLessonsState extends State<UngradedLessons> {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);
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
                              "Ungraded Lessons",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder(
                        future: viewModel.GetUngradedLessons(userId!),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.hasData) {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LessonDetailPage(
                                              lesson_id: snapshot
                                                  .data[index].lesson.id,
                                              lesson_date: snapshot
                                                  .data[index].lesson.startDate
                                                  .toString(),
                                              lesson_time: snapshot.data[index]
                                                  .lesson.estimatedTime
                                                  .toString(),
                                              lesson_name: snapshot
                                                  .data[index].lesson.name,
                                              lesson_description: snapshot
                                                      .data[index]
                                                      .lesson
                                                      .description ??
                                                  " ",
                                              lesson_level: snapshot.data[index]
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
                                        child: CompletedLessonCard(
                                            data: snapshot.data[index],
                                            buttonBar: RatingBar.builder(
                                              itemSize: 30,
                                              initialRating:
                                                  snapshot.data[index].rate ??
                                                      0,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) async {
                                                debugPrint(rating.toString());
                                                await HomeScreenViewModel()
                                                    .PostLessonRate(
                                                        userId!,
                                                        snapshot.data[index]
                                                            .lesson.id,
                                                        rating);
                                                // await Future.delayed(
                                                //     const Duration(seconds: 5));
                                                // await HomeScreenViewModel()
                                                //     .GetUngradedLessons(userId!)
                                                //     .then((value) =>
                                                //         setState(() {}));
                                              },
                                            )),
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
