import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/text_lesson_card.dart';
import 'package:studio_reservation_app/core/base/base_viewmodel.dart';
import 'package:studio_reservation_app/viewmodels/home_view_model.dart';

import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: HomeViewModel(),
      onModelReady: (HomeViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, HomeViewModel viewModel) =>
          SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FutureBuilder(
                    future: HomeViewModel().memberDetails(userId!),
                    builder: (context, AsyncSnapshot snapshot) => Column(
                      children: [
                        Stack(alignment: Alignment.center, children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xffFF3E85),
                                width: 3,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/trainer1.png"),
                          ),
                        ]),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data!.name + " " + snapshot.data!.surname,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            snapshot.data!.memberType == 1
                                ? "Online"
                                : "Onsite",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  Text('Profile'),
                  ExpansionTile(title: Text("data"), children: [
                    TextLessonCard(text: "text1"),
                    TextLessonCard(text: "text"),
                    TextLessonCard(text: "text")
                  ]),
                  ExpansionTile(title: Text("data"), children: [
                    TextLessonCard(text: "text1"),
                    TextLessonCard(text: "text"),
                    TextLessonCard(text: "text")
                  ]),
                  ExpansionTile(title: Text("data"), children: [
                    TextLessonCard(text: "text1"),
                    TextLessonCard(text: "text"),
                    TextLessonCard(text: "text")
                  ])
                ]),
          ),
        ),
      ),
    );
  }
}
