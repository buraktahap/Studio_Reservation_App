import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/main.dart';
import 'package:studio_reservation_app/models/lesson_response_model.dart';
import 'package:studio_reservation_app/models/member_details_response.dart';
import 'package:studio_reservation_app/models/member_lesson_response.dart';

import '../classes/lesson.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/constants/network/network_constants.dart';
import '../core/enums/url_enum.dart';
import '../core/init/cache/locale_manager.dart';
part 'home_screen_view_model.g.dart';

class HomeScreenViewModel = _HomeScreenViewModelBase with _$HomeScreenViewModel;

abstract class _HomeScreenViewModelBase with Store {
  final dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstants.BASE_URL,
      headers: {"Content-Type": "application/json"},
    ),
  );

  @observable
  void checkInLessonDetails() async {
    try {
      final response =
          await dio.get(Urls.ReservationList.rawValue, queryParameters: {
        'id': userId,
      });
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          print(responseBody);
          final checkInLessonDetails = responseBody
              .map((e) => LessonResponseModel.fromJson(e))
              .toList();
          print(checkInLessonDetails[0].id);

          await LocaleManager.instance
              .setIntValue(PreferencesKeys.CHECKIN_ID,checkInLessonDetails[0].id );
      }
    } on DioError catch (e) {
      print("e");
    }
    return null;
  }
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);

  final int? checkInId =
      LocaleManager.instance.getIntValue(PreferencesKeys.CHECKIN_ID);
  @observable
  void CheckIn() async {
    try {
      final response = await dio.post(Urls.CheckIn.rawValue,
          data: jsonEncode(
              memberLessonResponse(memberId: userId, lessonId: checkInId)
                  .toJson()));
      print(response.data);
      switch (response.statusCode) {
        case HttpStatus.ok:
          return print("checkin completed");
      }
    } on DioError catch (e) {
      print("checkIn failed");

      await LocaleManager.instance.setIntValue(PreferencesKeys.CHECKIN_ID, 0);
    }
  }

  @observable
  List reservations = [];

  @observable
  Future<List<LessonResponseModel>?> reservationList() async {
    final response = await dio
        .get(Urls.ReservationList.rawValue, queryParameters: {'id': userId});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data;
        if (responseBody is List) {
          return reservations = responseBody
              .map((e) => LessonResponseModel.fromJson(e))
              .toList();
        }
        return Future.error(responseBody);
    }
    return null;
  }

  @observable
  void EnrollCancel() async {
    try {
      final response = await dio.post(Urls.EnrollCancel.rawValue,
          data: jsonEncode(
              memberLessonResponse(memberId: userId, lessonId: checkInId)
                  .toJson()));
      print(response.data);
      switch (response.statusCode) {
        case HttpStatus.ok:
          await LocaleManager.instance
              .setIntValue(PreferencesKeys.CHECKIN_ID, 0);
          return print("enroll canceled");
      }
    } on DioError catch (e) {
      print("cancel failed");
    }
  }

  @observable
  Future<LessonResponseModel?> checkInLesson() async {
    try {
      final response =
          await dio.get(Urls.GetLessonById.rawValue, queryParameters: {
        'id': checkInId,
      });
      print(response.data);
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          final LessonResponseModel checkInLesson =
              LessonResponseModel.fromJson(responseBody);

          print(responseBody);
          return checkInLesson;
      }
    } on DioError catch (e) {
      print("e");
    }
    return null;
  }
}
