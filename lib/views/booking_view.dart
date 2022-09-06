import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/enroll_lesson_Card.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';
import '../components/action_buttons.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../models/branch_location_response.dart';
import '../viewmodels/location_selection_view_model.dart';
import 'lesson_detail_page.dart';

final String? userLocation =
    LocaleManager.instance.getStringValue(PreferencesKeys.userLocation);
BranchLocationResponseModel _selectedCity =
    BranchLocationResponseModel(name: userLocation ?? "Select Branch");

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.userId);
  var branches = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await LocationSelectionViewModel().getAllLocations();
      branches = LocationSelectionViewModel().cities;
      setState(() {});
    });
  }

  final LocationSelectionViewModel locationViewModel =
      LocationSelectionViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView<BookingViewModel>(
        viewModel: BookingViewModel(),
        onModelReady: (BookingViewModel model) {
          LocationSelectionViewModel().setContext(context);
          LocationSelectionViewModel().init();
        },
        onPageBuilder: (BuildContext context, BookingViewModel model) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 45, 15, 0),
                  child: cities(locationViewModel),
                ),
                Expanded(
                  child: FutureBuilder(
                      future: BookingViewModel()
                          .lessonsByBranchName(_selectedCity.name),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LessonDetailPage(
                                          lessonId: snapshot.data[index].id,
                                          lessonDate: snapshot
                                              .data[index].startDate
                                              .toString(),
                                          lessonTime: snapshot
                                              .data[index].estimatedTime
                                              .toString(),
                                          lessonName: snapshot.data[index].name,
                                          lessonDescription: snapshot
                                                  .data[index].description ??
                                              " ",
                                          lessonLevel: snapshot
                                              .data[index].lessonLevel
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
                                    child: EnrollLessonCard(
                                      data: snapshot.data[index],
                                      buttonOrText: ActionButtons(
                                        lessonId: snapshot.data[index].id,
                                        align: Alignment.centerLeft,
                                      ),
                                    ),
                                  );
                                });
                          }
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(15, 45, 15, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.75,
                              alignment: Alignment.center,
                              child: Text(
                                "${_selectedCity.name.toString()} doesn't have any lesson at the moment. Please check later.",
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
              ],
            ));
  }

  Widget cities(LocationSelectionViewModel viewModel) {
    return GestureDetector(
      onTap: () {},
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
          underline: Container(),
          isExpanded: false,
          onTap: () {},
          hint: Text(
            _selectedCity.name.toString(),
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontSize: 25),
          ),
          alignment: AlignmentDirectional.topStart,
          elevation: 16,
          itemHeight: 60,
          borderRadius: BorderRadius.circular(30),
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontSize: 18),
          icon: Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Icon(
              Icons.expand_more,
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
          items: branchLocations(viewModel),
          onChanged: (item) {
            _selectedCity.name = item.toString();
            BranchLocationResponseModel(
              name: _selectedCity.name,
            );
            setState(() {});
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> branchLocations(
      LocationSelectionViewModel viewModel) {
    viewModel.getAllLocations();
    return viewModel.cities.map((item) {
      return DropdownMenuItem(
        value: item.name.toString(),
        child: item.name.toString() == _selectedCity.name.toString()
            ? Text(
                item.name.toString(),
                style: TextStyle(
                    color: Theme.of(context).shadowColor, fontSize: 18),
              )
            : Text(
                item.name.toString(),
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 18),
              ),

        // child: Text(item.name.toString()),
      );
    }).toList();
  }
}
