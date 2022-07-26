import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/classes/Member.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/core/base/view/base_view.dart';
import 'package:studio_reservation_app/viewmodels/login_view_model.dart';

import '../viewmodels/location_selection_view_model.dart';

class LocationSelectionView extends StatefulWidget {
  LocationSelectionView({Key? key}) : super(key: key);
  late Future<Member> futureAlbum;

  @override
  State<LocationSelectionView> createState() => _LocationSelectionViewState();
}

class _LocationSelectionViewState extends State<LocationSelectionView> {
  String _selectedCity = "İzmir";
  @override
  Widget build(BuildContext context) {
    return BaseView<LocationSelectionViewModel>(
        viewModel: LocationSelectionViewModel(),
        onModelReady: (LocationSelectionViewModel model) {},
        onPageBuilder: (BuildContext context,
                LocationSelectionViewModel viewModel) =>
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
                            Expanded(flex: 2, child: cities()),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child:
                                    ColoredButton(text: "->", onPressed: () {}))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Container cities() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: DropdownButton(
        alignment: Alignment.center,
        value: _selectedCity,
        elevation: 16,
        borderRadius: BorderRadius.circular(25),
        style: const TextStyle(color: Colors.black),
        icon: const Icon(Icons.arrow_downward),
        items: <String>['İzmir', 'İstanbul', 'Bursa', 'Antalya', 'Ankara']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedCity = value.toString();
            print("------city:" + _selectedCity);
          });
        },
      ),
    );
  }
}
