import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_reservation_app/classes/member.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/models/branch_location_response.dart';
import 'package:studio_reservation_app/models/member_location_update.dart';
import 'package:studio_reservation_app/models/sign_in_response.dart';
import 'package:studio_reservation_app/static_member.dart';

import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../viewmodels/location_selection_view_model.dart';

class LocationSelectionView extends StatefulWidget {
  LocationSelectionView({Key? key}) : super(key: key);

  @override
  State<LocationSelectionView> createState() => _LocationSelectionViewState();
}

class _LocationSelectionViewState extends State<LocationSelectionView> {
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
                                    color: Colors.white,
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
                            child: Row(
                              children: [
                                Expanded(flex: 2, child: cities(viewModel)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: ColoredButton(
                                        text: "Approve",
                                        onPressed: () {
                                          viewModel.MemberLocationUpdate(
                                              userId, _selectedCity.name);
                                        }))
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
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: GestureDetector(
        onTap: () {
          viewModel.GetAllLocations();
          setState(() {});
        },
        child: Center(
          child: DropdownButton(
            underline: Container(),
            isExpanded: true,
            onTap: () {
              setState(() {
                viewModel.GetAllLocations();
              });
            },
            hint: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(_selectedCity.name.toString()),
            ),
            alignment: Alignment.center,
            elevation: 16,
            borderRadius: BorderRadius.circular(25),
            style: const TextStyle(color: Colors.black, fontSize: 18),
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

  // List<DropdownMenuItem<Object>> branchLocationList(
  //     LocationSelectionViewModel viewModel) {
  //   return viewModel.cities.map((item) {
  //     return DropdownMenuItem(
  //       value: item,
  //       child: Text(item.name),
  //     );
  //   }).toList();
  // }

  List<DropdownMenuItem<String>> branchLocations(
      LocationSelectionViewModel viewModel) {
    return viewModel.cities.map((item) {
      return DropdownMenuItem(
        value: item.name.toString(),
        child: Text(item.name.toString()),
      );
    }).toList();
  }
}
