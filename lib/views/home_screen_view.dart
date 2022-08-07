import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/classes/member.dart';
import 'package:studio_reservation_app/components/enroll_lesson_card.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/models/member_location_update_response.dart';
import 'package:studio_reservation_app/static_member.dart';
import 'package:studio_reservation_app/views/home_view.dart';

import '../components/last_completed_lesson_card.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../viewmodels/home_screen_view_model.dart';
import '../viewmodels/home_view_model.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  HomeViewModel homeViewModel = HomeViewModel();

  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
      viewModel: HomeScreenViewModel(),
      onModelReady: (HomeScreenViewModel model) {},
      onPageBuilder: (BuildContext context, HomeScreenViewModel viewModel) =>
          ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                FutureBuilder(
                    future: HomeViewModel().memberDetails(userId!),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello ${snapshot.data.name}, welcome to ${snapshot.data.location}.",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 16),
                                  ),
                                  const Text(
                                    "Let's Get Exercise",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                ],
                              ),
                              const Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
          EnrollLessonCard(),
          LastCompletedLessonCard(),
          Row(
            children: [Container()],
          ),
          Row(
            children: [Container()],
          ),
        ],
      ),
    );
  }
}
