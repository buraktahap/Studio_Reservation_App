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

  bool isCheckin = false;

  @action
  void setCheckin(bool value) => isCheckin = value;

  @observable
  Future<MemberLessonResponse?> checkInLessonDetails() async {
    try {
      var response =
          await dio.get(Urls.CheckInLessonDetails.rawValue, queryParameters: {
        'id': userId,
      });
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          final MemberLessonResponse checkInLesson =
              MemberLessonResponse.fromJson(responseBody);

          print(responseBody);
          return checkInLesson;

        case HttpStatus.notFound:
          return null;
        // case HttpStatus.accepted:
        //   final responseBody = await response.data;
        //   final LessonResponseModel checkInLesson =
        //       LessonResponseModel.fromJson(responseBody);

        //   print(responseBody);
        //   return checkInLesson;
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
  void CheckIn(int lessonId) async {
    MemberLessonResponse? x = await checkInLessonDetails();
    try {
      final response = await dio.post(Urls.CheckIn.rawValue,
          queryParameters: {'memberId': userId, 'lessonId': lessonId});
      print(response.data);
      switch (response.statusCode) {
        case HttpStatus.ok:
          print("checkin completed");
      }
    } on DioError catch (e) {
      print("checkIn failed");

      await LocaleManager.instance.setIntValue(PreferencesKeys.CHECKIN_ID, 0);
    }
  }

  @observable
  List reservations = [];

  @observable
  Future<List<MemberLessonResponse>?> reservationList() async {
    final response = await dio
        .get(Urls.ReservationList.rawValue, queryParameters: {'id': userId});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data;
        if (responseBody is List) {
          return reservations = responseBody
              .map((e) => MemberLessonResponse.fromJson(e))
              .toList();
        }
        return Future.error(responseBody);
    }
    return null;
  }

  @observable
  void EnrollCancel() async {
    MemberLessonResponse? x = await checkInLessonDetails();
    try {
      final response = await dio.post(Urls.EnrollCancel.rawValue,
          data: jsonEncode(
              MemberLessonResponse(memberId: userId, lessonId: x?.lessonId)
                  .toJson()));
      print(response.data);
      switch (response.statusCode) {
        case HttpStatus.ok:
          await reservationList();
          if (reservations.isNotEmpty) {
            await LocaleManager.instance
                .setIntValue(PreferencesKeys.CHECKIN_ID, reservations[0].id);
            return print("enroll canceled");
          } else {
            await LocaleManager.instance
                .setIntValue(PreferencesKeys.CHECKIN_ID, 0);
            return print("enroll canceled and no lesson for checkin");
          }
      }
    } on DioError catch (e) {
      print("cancel failed");
    }
  }

  @observable
  Future<List?> checkInLessonJoined() async {
    List checkInLessonJoinedDetails = [];
    MemberLessonResponse? ml = await checkInLessonDetails();
    LessonResponseModel? lr = await checkInLesson();
    checkInLessonJoinedDetails.add(ml);
    checkInLessonJoinedDetails.add(lr);
    return checkInLessonJoinedDetails;
  }

  @observable
  Future<LessonResponseModel?> checkInLesson() async {
    MemberLessonResponse? ml = await checkInLessonDetails();
    try {
      final response =
          await dio.get(Urls.GetLessonById.rawValue, queryParameters: {
        'id': ml?.lessonId,
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
