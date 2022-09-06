import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/models/enroll_cancel_member_lesson_post.dart';
import 'package:studio_reservation_app/models/lesson_response_model.dart';
import 'package:studio_reservation_app/models/member_lesson_response.dart';
import 'package:studio_reservation_app/models/member_lesson_with_lesson_included.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/constants/network/network_constants.dart';
import '../core/enums/url_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../models/member_lesson_by_member_and_lesson_id.dart';
part 'home_screen_view_model.g.dart';

class HomeScreenViewModel = _HomeScreenViewModelBase with _$HomeScreenViewModel;

abstract class _HomeScreenViewModelBase with Store {
  final dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
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
          await dio.get(Urls.checkInLessonDetails.rawValue, queryParameters: {
        'id': userId,
      });
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          final MemberLessonResponse checkInLesson =
              MemberLessonResponse.fromJson(responseBody);

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
      debugPrint(e.toString());
    }
    return null;
  }

  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.userId);

  final int? checkInId =
      LocaleManager.instance.getIntValue(PreferencesKeys.checkinId);

  @observable
  Future checkIn(int lessonId) async {
    try {
      final response = await dio.post(Urls.checkIn.rawValue,
          queryParameters: {'memberId': userId, 'lessonId': lessonId});
      switch (response.statusCode) {
        case HttpStatus.ok:
          debugPrint("checkin completed");
      }
    } on DioError {
      debugPrint("checkIn failed");

      await LocaleManager.instance.setIntValue(PreferencesKeys.checkinId, 0);
    }
  }

  @observable
  List reservations = [];

  @observable
  Future<List<MemberLessonResponse>?> reservationList() async {
    final response = await dio
        .get(Urls.reservationList.rawValue, queryParameters: {'id': userId});
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
  List x = [];
  @action
  Future<List> memberLessonByMemberAndLessonIdWithIndex(int lessonId) async {
    final LessonResponseModel? a = await getLessonById(lessonId);
    x.add(a);
    int? b = await getWaitingQueueIndexByMemberAndLessonId(lessonId);
    x.add(b);
    return x;
  }

  @action
  Future<MemberLessonByMemberAndLessonId?> getMemberLessonByLessonAndMemberId(
      int lessonId) async {
    try {
      final response = await dio.get(
          Urls.getMemberLessonsByMemberIdByLessonId.rawValue,
          queryParameters: {'memberId': userId, 'lessonId': lessonId});
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          if (responseBody != null) {
            MemberLessonByMemberAndLessonId responseData =
                MemberLessonByMemberAndLessonId.fromJson(responseBody);
            return responseData;
          }
      }
    } on DioError catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @observable
  Future enrollCancel(int lessonId) async {
    try {
      final response = await dio.post(Urls.enrollCancel.rawValue,
          data: jsonEncode(EnrollCancelMemberLessonPost(
                  memberId: userId!, lessonId: lessonId)
              .toJson()));
      switch (response.statusCode) {
        case HttpStatus.ok:
          debugPrint("enroll canceled");
      }
    } on DioError {
      debugPrint("cancel failed");
    }
  }

  // @observable
  // Future<List?> checkInLessonJoined() async {
  //   List checkInLessonJoinedDetails = [];
  //   MemberLessonResponse? ml = await checkInLessonDetails();
  //   LessonResponseModel? lr = await checkInLesson();
  //   checkInLessonJoinedDetails.add(ml);
  //   checkInLessonJoinedDetails.add(lr);
  //   return checkInLessonJoinedDetails;
  // }

  @observable
  Future<LessonResponseModel?> checkInLesson() async {
    MemberLessonResponse? ml = await checkInLessonDetails();
    try {
      final response =
          await dio.get(Urls.getLessonById.rawValue, queryParameters: {
        'id': ml?.lessonId,
      });
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          final LessonResponseModel checkInLesson =
              LessonResponseModel.fromJson(responseBody);

          return checkInLesson;
      }
    } on DioError {
      debugPrint("e");
    }
    return null;
  }

  @observable
  Future<LessonResponseModel?> getLessonById(int lessonId) async {
    try {
      final response =
          await dio.get(Urls.getLessonById.rawValue, queryParameters: {
        'id': lessonId,
      });
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          final LessonResponseModel checkInLesson =
              LessonResponseModel.fromJson(responseBody);

          return checkInLesson;
      }
    } on DioError catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @observable
  Future<LessonResponseModel?> addToWaitingQueue(int lessonId) async {
    try {
      final response = await dio.post(Urls.addToWaitingQueue.rawValue,
          data: jsonEncode(EnrollCancelMemberLessonPost(
                  memberId: userId!, lessonId: lessonId)
              .toJson()));
      switch (response.statusCode) {
        case HttpStatus.ok:
          return null;
        case HttpStatus.unauthorized:
          return null;
      }
    } on DioError catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @action
  Future<int?> getWaitingQueueIndexByMemberAndLessonId(int lessonId) async {
    try {
      final response = await dio.get(
          Urls.getWaitingQueueIndexByMemberAndLessonId.rawValue,
          queryParameters: {'memberId': userId, 'lessonId': lessonId});
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          int waitingQueueIndex = responseBody;
          return waitingQueueIndex;
        case HttpStatus.notFound:
          return 0;
      }
    } on DioError catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @action
  Future<List?> getCompletedLessons(int memberId) async {
    try {
      final response =
          await dio.get(Urls.getCompletedLesson.rawValue, queryParameters: {
        'memberId': memberId,
      });
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          final completedLessons = responseBody
              .map((e) => MemberLessonWithLessonIncluded.fromJson(e))
              .toList();

          return completedLessons;
      }
    } on DioError {
      debugPrint("get completed lessons failed");
    }
    return null;
  }

  @action
  Future<int?> getCompletedLessonCount(int lessonId) async {
    try {
      final response = await dio.get(Urls.getCompletedLessonCount.rawValue,
          queryParameters: {'memberId': userId});
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          int count = responseBody;
          return count;
        case HttpStatus.notFound:
          return null;
      }
    } on DioError catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @action
  Future<List?> getUngradedLessons(int memberId) async {
    try {
      final response = await dio
          .get(Urls.getUngradedMemberLessons.rawValue, queryParameters: {
        'memberId': memberId,
      });
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          final ungradedMemberLessons = responseBody
              .map((e) => MemberLessonWithLessonIncluded.fromJson(e))
              .toList();

          return ungradedMemberLessons;
      }
    } on DioError {
      debugPrint("get ungraded lessons failed");
    }
    return null;
  }

  @action
  Future postLessonRate(int memberId, int lessonId, double rate) async {
    try {
      final response = await dio.post(Urls.postLessonRate.rawValue,
          queryParameters: {
            'memberId': memberId,
            'lessonId': lessonId,
            'rate': rate
          });
      switch (response.statusCode) {
        case HttpStatus.ok:
          debugPrint(response.data.toString());
      }
      debugPrint(response.data.toString());
    } on DioError {
      debugPrint("post lesson rate failed");
    }
    return null;
  }
}
