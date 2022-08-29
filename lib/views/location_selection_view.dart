import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/core/init/notifier/theme_notifier.dart';
import 'package:studio_reservation_app/models/branch_location_response.dart';
import 'package:studio_reservation_app/models/sign_in_response.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../viewmodels/location_selection_view_model.dart';

class LocationSelectionView extends StatefulWidget {
  LocationSelectionView({Key? key}) : super(key: key);

  @override
  State<LocationSelectionView> createState() => _LocationSelectionViewState();
}

class _LocationSelectionViewState extends State<LocationSelectionView> {
  var branches = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await LocationSelectionViewModel().GetAllLocations();
      branches = LocationSelectionViewModel().cities;
      setState(() {});
    });
  }

  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);

  final BranchLocationResponseModel _selectedCity =
      BranchLocationResponseModel(name: "Select Branch");
  final SignInResponseModel signInResponseModel = SignInResponseModel();
  @override
  Widget build(BuildContext context) {
    return BaseView<LocationSelectionViewModel>(
        viewModel: LocationSelectionViewModel(),
        onModelReady: (LocationSelectionViewModel model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder:
            (BuildContext context, LocationSelectionViewModel viewModel) =>
                Scaffold(
                  body: Background(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                  "Please select your branch to continue.",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Quicksand',
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                cities(viewModel),
                                const SizedBox(
                                  height: 30,
                                ),
                                ColoredButton(
                                    text: "Approve",
                                    onPressed: () {
                                      viewModel.MemberLocationUpdate(
                                          userId!, _selectedCity.name);
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
  }

  Widget cities(LocationSelectionViewModel viewModel) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border: Border.all(width: 1, color: const Color(0xffFF34C6))),
      child: GestureDetector(
        onTap: () {},
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            underline: Container(),
            isExpanded: true,
            onTap: () {
              setState(() {
                viewModel.GetAllLocations();
              });
            },
            hint: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(_selectedCity.name.toString()),
            ),
            alignment: Alignment.center,
            elevation: 16,
            itemHeight: 60,
            borderRadius: BorderRadius.circular(30),
            style: TextStyle(
                color: ThemeNotifier().currentTheme.textTheme.bodyText1?.color,
                fontSize: 18),
            icon: const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Icon(
                Icons.expand_more,
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
      ),
    );
  }

  List<DropdownMenuItem<String>> branchLocations(
      LocationSelectionViewModel viewModel) {
    viewModel.GetAllLocations();
    return viewModel.cities.map((item) {
      return DropdownMenuItem(
        value: item.name.toString(),
        child: Text(item.name.toString()),
      );
    }).toList();
  }
}
