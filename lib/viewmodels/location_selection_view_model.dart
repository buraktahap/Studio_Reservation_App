import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:studio_reservation_app/classes/member.dart';
import 'package:studio_reservation_app/models/branch_location_response.dart';
import 'package:studio_reservation_app/models/member_location_update.dart';
import 'package:studio_reservation_app/models/member_location_update_response.dart';
import 'package:studio_reservation_app/models/sign_in_response.dart';
import 'package:studio_reservation_app/static_member.dart';
import 'package:studio_reservation_app/views/home_screen_view.dart';
import 'package:studio_reservation_app/models/member_lesson_response.dart';
import 'package:studio_reservation_app/views/home_view.dart';
import '../core/base/base_viewmodel.dart';
import '../core/base/model/base_viewmodel.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/constants/network/network_constants.dart';
import '../core/enums/url_enum.dart';
import '../core/init/cache/locale_manager.dart';
part 'location_selection_view_model.g.dart';

class LocationSelectionViewModel = _LocationSelectionViewModelBase
    with _$LocationSelectionViewModel;

abstract class _LocationSelectionViewModelBase with Store, BaseViewModel {
  List<BranchLocationResponseModel> cities = [];

  @override
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {
    var cities = (await GetAllLocations()) ?? [];
  }

  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);

  @observable
  List<BranchLocationResponseModel>? categories =
      <BranchLocationResponseModel>[];
  @observable
  List<MultiSelectItem<BranchLocationResponseModel>> cityList =
      <MultiSelectItem<BranchLocationResponseModel>>[];

  // @observable
  // List<BranchLocationResponseModel>? cities =
  //     <BranchLocationResponseModel>[];

  final dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstants.BASE_URL,
      headers: {"Content-Type": "application/json"},
    ),
  );
  @observable
  Future<List<BranchLocationResponseModel>?> GetAllLocations() async {
    final response = await dio.get(Urls.GetAllLocations.rawValue);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data;
        if (responseBody is List) {
          return cities = responseBody
              .map((e) => BranchLocationResponseModel.fromJson(e))
              .toList();
        }
        return Future.error(responseBody);
    }
    return null;
  }

  @observable
  void MemberLocationUpdate(int userId, String? location) async {
    try {
      final response = await dio.post(Urls.MemberLocationUpdate.rawValue,
          data: jsonEncode(
              SignInResponseModel(id: userId, location: location).toJson()));

      switch (response.statusCode) {
        case HttpStatus.ok:
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
              ((r) => false));
          await LocaleManager.instance.setStringValue(
              PreferencesKeys.USER_LOCATION, location as String);
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a location")));
    }
  }

  // @action
  // Future<Object?> LocationUpdate(int? id, String location) async {
  //   try {
  //     final response = await dio.post(
  //       Urls.MemberLocationUpdate.rawValue,
  //       data: json.encode(SignInResponseModel(
  //         id: id,
  //         location: location,
  //       ).toJson()),
  //     );
  //     switch (response.statusCode) {
  //       case HttpStatus.ok:
  //         final MemberLocationUpdateResponse appLocationUpdateResponse =
  //             await MemberLocationUpdateResponse.fromJson(response.data);
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => HomeView()));

  //         break;
  //       case HttpStatus.notFound:
  //         location == "Select Branch"
  //             ? print("Please select a location")
  //             : print("Please select a location");
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text("Invalid email or password"),
  //         ));
  //         break;
  //     }
  //   } on DioError catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text("Please enter registered email and password")));
  //   }
  //   return null;
  // }

  // Future<List<BranchLocationResponseModel>?> GetAllLocations() async {
  //   // try {
  //   print("try girdi");
  //   final response = await dio.get(Urls.GetAllLocations.rawValue);

  //   // BranchLocationResponse branchLocationResponse =
  //   //     BranchLocationResponse.fromJson(response.data);

  //   // data:
  //   //     BranchLocationResponse.fromJson();
  //   print(response.data);
  //   switch (response.statusCode) {
  //     case HttpStatus.ok:
  //       final responseBody = await response.data["data"];
  //       if (responseBody is List) {
  //         return responseBody
  //             .map((e) => BranchLocationResponseModel.fromJson(e.value))
  //             .toList();
  //       }
  //   }
  //   return null;
  //   //   switch (response.statusCode) {
  //   //     case HttpStatus.ok:
  //   //       final BranchLocationResponse appBranchLocationResponse =
  //   //           await BranchLocationResponse.fromJson(response.data);
  //   //       Navigator.push(
  //   //           context, MaterialPageRoute(builder: (context) => HomeView()));
  //   //       break;
  //   //     case HttpStatus.notFound:
  //   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //   //         content: Text("Invalid email or password"),
  //   //       ));
  //   //       break;
  //   //   }
  //   // } on DioError catch (e) {
  //   //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //   //       content: Text("Please enter registered email and password")));
  //   // }
  //   // return null;
  // }
}
