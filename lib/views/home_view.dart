import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/core/constants/enums/preferences_keys_enum.dart';
import 'package:studio_reservation_app/viewmodels/home_screen_view_model.dart';
import 'package:studio_reservation_app/viewmodels/home_view_model.dart';
import 'package:studio_reservation_app/views/booking_view.dart';
import 'package:studio_reservation_app/views/home_screen_view.dart';
import 'package:studio_reservation_app/views/profile_page.dart';
import 'package:studio_reservation_app/views/splash_screen.dart';

import 'package:studio_reservation_app/core/base/view/base_view.dart';
import '../core/init/cache/locale_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String? userLocation =
      LocaleManager.instance.getStringValue(PreferencesKeys.USER_LOCATION);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var p = HomeScreenViewModel().reservationList();
      setState(() {});
    });
  }

  var x = HomeScreenViewModel().reservations;
  int pageIndex = 1;
  late final PageController _pageController = PageController(initialPage: 1);

  final pages = [
    const HomeScreenView(),
    const BookingView(),
    const ProfilePage(),
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
                body: Background(
                  child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          pageIndex = index;
                        });
                      },
                      children: pages),
                ),
                bottomNavigationBar: buildMyNavBar(context)));
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
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
              pageIndex = 0;
              _pageController.jumpToPage(pageIndex);
              setState(() {});
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_outlined,
                    color: Color.fromARGB(255, 253, 12, 146),
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    size: 35,
                  ),
          ),
          IconButton(
            tooltip: "Search",
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
                _pageController.jumpToPage(pageIndex);
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
                    size: 35,
                  ),
          ),
          IconButton(
            tooltip: "Profile",
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
                _pageController.jumpToPage(pageIndex);
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