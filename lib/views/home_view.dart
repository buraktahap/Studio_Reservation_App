import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/lesson_CArd.dart';
import 'package:studio_reservation_app/viewmodels/home_view_model.dart';
import 'package:studio_reservation_app/views/home_screen_view.dart';
import 'package:studio_reservation_app/views/splash_screen.dart';

import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'location_selection_view.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int pageIndex = 0;

  final pages = [
    const HomeScreenView(),
    const LessonCard(),
    const SplashScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        viewModel: HomeViewModel(),
        onModelReady: (HomeViewModel model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, HomeViewModel viewModel) =>
            Scaffold(
                extendBody: true,
                body: Background(child: pages[pageIndex]),
                bottomNavigationBar: buildMyNavBar(context)));
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xff373856),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_outlined,
                    color: Color.fromARGB(255, 253, 12, 146),
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            tooltip: "Search",
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.search_outlined,
                    color: Color.fromARGB(255, 253, 12, 146),
                    size: 35,
                  )
                : const Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.person_outline,
                    color: Color.fromARGB(255, 253, 12, 146),
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          // IconButton(
          //   enableFeedback: false,
          //   onPressed: () {
          //     setState(() {
          //       pageIndex = 3;
          //     });
          //   },
          //   icon: pageIndex == 3
          //       ? const Icon(
          //           Icons.more_vert,
          //           color: Color.fromARGB(255, 253, 12, 146),
          //           size: 35,
          //         )
          //       : const Icon(
          //           Icons.more_vert,
          //           color: Colors.white,
          //           size: 35,
          //         ),
          // ),
        ],
      ),
    );
  }
}
// BottomNavigationBar(
//                   items: const [
//                     BottomNavigationBarItem(
//                       backgroundColor: Color.fromARGB(1, 55, 56, 81),
//                       icon: Icon(Icons.home),
//                       label: 'Home',
//                     ),
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.search), label: 'Search'),
//                     BottomNavigationBarItem(
//                       icon: Icon(Icons.person),
//                       label: 'Profile',
//                     ),
//                   ],
//                 ),