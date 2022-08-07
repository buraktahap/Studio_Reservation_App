import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/classes/lesson.dart';
import 'package:studio_reservation_app/core/base/model/base_viewmodel.dart';
import 'package:studio_reservation_app/core/constants/network/network_constants.dart';
import 'package:studio_reservation_app/core/enums/url_enum.dart';
import 'package:studio_reservation_app/models/enrollResponseModel.dart';
import 'package:studio_reservation_app/models/lesson_response_model.dart';
import 'package:studio_reservation_app/models/member_details_response.dart';
import 'package:studio_reservation_app/models/member_lesson_response.dart';
import 'package:studio_reservation_app/models/sign_in_response.dart';
import 'package:studio_reservation_app/viewmodels/location_selection_view_model.dart';
part 'booking_view_model.g.dart';

class BookingViewModel = _BookingViewModelBase with _$BookingViewModel;

abstract class _BookingViewModelBase with Store {
  @observable
  String enrollStatus = "Enroll";
  // @override
  // void setContext(BuildContext context) =>  this.context= context;
  @override
  void init() {
    LessonsByBranchName(branchName);
  }

  late String branchName;
  final dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstants.BASE_URL,
      headers: {"Content-Type": "application/json"},
    ),
  );
  @observable
  List lessons = [];

  @observable
  Future<List<LessonResponseModel>?> LessonsByBranchName(
      String? Location) async {
    try {
      final response =
          await dio.get(Urls.LessonsByBranchName.rawValue, queryParameters: {
        'branchName': Location,
      });
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          if (responseBody is List) {
            return lessons = responseBody
                .map((e) => LessonResponseModel.fromJson(e))
                .toList();
          }
      }
    } on DioError catch (e) {
      print("e");
    }
  }

  @observable
  Future Enroll(int memberId, int lessonId) async {
    try {
      final response = await dio.post(Urls.Enroll.rawValue,
          data: json.encode(
              enrollResponseModel(memberId: memberId, lessonId: lessonId)
                  .toJson()));
      switch (response.statusCode) {
        case HttpStatus.created:
          final responseBody = await response.data;
          MemberDetailsResponse memberDetailsResponse =
              await responseBody.map((e) => MemberDetailsResponse.fromJson(e));
          break;
      }
    } on DioError catch (e) {
      enrollStatus = "You have already enrolled";
      print("e");
      return null;
    }
  }
}
