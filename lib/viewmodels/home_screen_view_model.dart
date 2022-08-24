import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/models/enroll_cancel_member_lesson_post.dart';
import 'package:studio_reservation_app/models/lesson_response_model.dart';
import 'package:studio_reservation_app/models/member_lesson_response.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/constants/network/network_constants.dart';
import '../core/enums/url_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../models/member_lesson_by_member_and_lessonId.dart';
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
  Future CheckIn(int lessonId) async {
    try {
      final response = await dio.post(Urls.CheckIn.rawValue,
          queryParameters: {'memberId': userId, 'lessonId': lessonId});
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
  Future<MemberLessonByMemberAndLessonId?> getMemberLessonByLessonAndMemberId(
      int lessonId) async {
    final response = await dio.get(
        Urls.GetMemberLessonsByMemberIdByLessonId.rawValue,
        queryParameters: {'memberId': userId, 'lessonId': lessonId});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data;
        if (responseBody != null) {
          MemberLessonByMemberAndLessonId responseData =
              MemberLessonByMemberAndLessonId.fromJson(responseBody);
          return responseData;
        }
        return Future.error(responseBody);
    }
    return null;
  }

  @observable
  Future EnrollCancel(int lessonId) async {
    try {
      final response = await dio.post(Urls.EnrollCancel.rawValue,
          data: jsonEncode(EnrollCancelMemberLessonPost(
                  memberId: userId!, lessonId: lessonId)
              .toJson()));
      switch (response.statusCode) {
        case HttpStatus.ok:
          print("enroll canceled");
      }
    } on DioError catch (e) {
      print("cancel failed");
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
          await dio.get(Urls.GetLessonById.rawValue, queryParameters: {
        'id': ml?.lessonId,
      });
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          final LessonResponseModel checkInLesson =
              LessonResponseModel.fromJson(responseBody);

          return checkInLesson;
      }
    } on DioError catch (e) {
      print("e");
    }
    return null;
  }

  @observable
  Future<LessonResponseModel?> getLessonById(int lessonId) async {
    try {
      final response =
          await dio.get(Urls.GetLessonById.rawValue, queryParameters: {
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
      print("e");
    }
    return null;
  }

  @observable
  Future<LessonResponseModel?> addToWaitingQueue(int lessonId) async {
    try {
      final response = await dio.post(Urls.AddToWaitingQueue.rawValue,
          data: jsonEncode(EnrollCancelMemberLessonPost(
                  memberId: userId!, lessonId: lessonId)
              .toJson()));
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          final LessonResponseModel checkInLesson =
              LessonResponseModel.fromJson(responseBody);

          return checkInLesson;
        case HttpStatus.unauthorized:
          return null;
      }
    } on DioError catch (e) {
      print("e");
    }
    return null;
  }

  @computed
  int waitingQueueIndex = 0;

  @observable
  Future<int> GetWaitingQueueIndexByMemberAndLessonId(int lessonId) async {
    final response = await dio.get(
        Urls.GetWaitingQueueIndexByMemberAndLessonId.rawValue,
        queryParameters: {'memberId': userId, 'lessonId': lessonId});
    waitingQueueIndex = await response.data;
    return waitingQueueIndex;
  }
}
