import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/classes/member.dart';
import 'package:studio_reservation_app/components/lesson_CArd.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/models/member_location_update_response.dart';
import 'package:studio_reservation_app/static_member.dart';

import '../viewmodels/home_screen_view_model.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Name Surname",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 16),
                    ),
                    const Text(
                      "let's Get Exercise",
                      style: TextStyle(color: Colors.white, fontSize: 30),
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
          ),
          LessonCard(),
          LessonCard(),
          LessonCard(),
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
