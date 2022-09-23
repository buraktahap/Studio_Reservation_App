import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/models/branch_location_response.dart';
import 'package:studio_reservation_app/models/sign_in_response.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../viewmodels/location_selection_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class LocationSelectionView extends StatefulWidget {
  const LocationSelectionView({Key? key}) : super(key: key);

  @override
  State<LocationSelectionView> createState() => _LocationSelectionViewState();
}

class _LocationSelectionViewState extends State<LocationSelectionView> {
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

  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.userId);

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
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
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
                                      viewModel.memberLocationUpdate(
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
    return DropdownButton2(
      disabledHint: Text(
        "Select Branch",
        style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1?.color,
            fontSize: 25,
            fontWeight: FontWeight.w300),
      ),
      alignment: Alignment.center,
      buttonWidth: (354 / MediaQuery.of(context).size.width) *
          MediaQuery.of(context).size.width,
      underline: Container(),
      buttonPadding: const EdgeInsets.only(left: 16),
      dropdownWidth: (354 / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width -
          20,
      barrierColor: Colors.pinkAccent.withOpacity(0.1),
      dropdownElevation: 15,
      buttonHeight: 30,
      dropdownDecoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.9999982118745121, 0.999980688244732),
          end: Alignment(0.9999982118745121, -1.0000038146677073),
          stops: [0.0, 1.0],
          colors: [
            Color.fromARGB(255, 255, 74, 173),
            Color.fromARGB(255, 253, 194, 178)
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      buttonElevation: 8,
      isExpanded: true,
      hint: Text(
        _selectedCity.name.toString(),
        style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1?.color,
            fontSize: 25,
            fontWeight: FontWeight.w300),
      ),
      itemHeight: 50,
      icon: Icon(
        Icons.expand_more,
        color: Theme.of(context).textTheme.bodyText1?.color,
      ),
      items: branchLocations(viewModel),
      onChanged: (item) {
        _selectedCity.name = item.toString();
        BranchLocationResponseModel(
          name: _selectedCity.name,
        );
        setState(() {});
      },
    );
  }

  List<DropdownMenuItem<String>> branchLocations(
      LocationSelectionViewModel viewModel) {
    viewModel.getAllLocations();
    return viewModel.cities.map((item) {
      return DropdownMenuItem(
        value: item.name.toString(),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            item.name.toString(),
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
          ),
        ),
      );
    }).toList();
  }
}
