import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/core/constants/network/network_constants.dart';
import 'package:studio_reservation_app/core/enums/url_enum.dart';
import 'package:studio_reservation_app/models/enroll_response_model.dart';
import 'package:studio_reservation_app/models/get_lessons_by_branc_by_enroll.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
part 'booking_view_model.g.dart';

class BookingViewModel = _BookingViewModelBase with _$BookingViewModel;

abstract class _BookingViewModelBase with Store {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.userId);

  @observable
  String enrollStatus = "Enroll";
  // @override
  // void setContext(BuildContext context) =>  this.context= context;
  void init() {
    lessonsByBranchNameandLessonLevel(branchName, lessonLevel);
  }

  String branchName = "";
  int lessonLevel = 0;
  final dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      headers: {"Content-Type": "application/json"},
    ),
  );
  @observable
  List lessons = [];

  @observable
  Future<List<GetLessonsByBranchNameWithEnroll>?>
      lessonsByBranchNameandLessonLevel(
          String? location, int lessonLevel) async {
    try {
      final response = await dio.post(
          Urls.getLessonsByBranchNameAndLessonLevel.rawValue,
          queryParameters: {
            'memberId': userId,
            'branchName': location,
            'lessonLevel': lessonLevel
          });
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          if (responseBody is List) {
            return lessons = responseBody
                .map((e) => GetLessonsByBranchNameWithEnroll.fromJson(e))
                .toList();
          }
      }
    } on DioError {
      debugPrint("LessonsByBranchName error");
    }
    return null;
  }

  @observable
  Future enroll(int lessonId) async {
    try {
      final response = await dio.post(Urls.enroll.rawValue,
          data: json.encode(
              EnrollResponseModel(memberId: userId, lessonId: lessonId)
                  .toJson()));
      switch (response.statusCode) {
        case HttpStatus.ok:
          return null;
      }
    } on DioError {
      debugPrint("enroll error");
      return null;
    }
  }
}
