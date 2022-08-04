import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/classes/lesson.dart';
import 'package:studio_reservation_app/core/base/model/base_viewmodel.dart';
import 'package:studio_reservation_app/core/constants/network/network_constants.dart';
import 'package:studio_reservation_app/core/enums/url_enum.dart';
import 'package:studio_reservation_app/models/lesson_response_model.dart';
import 'package:studio_reservation_app/models/sign_in_response.dart';
import 'package:studio_reservation_app/viewmodels/location_selection_view_model.dart';
part 'booking_view_model.g.dart';

class BookingViewModel = _BookingViewModelBase with _$BookingViewModel;

abstract class _BookingViewModelBase with Store {
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
            return lessons =responseBody
                .map((e) => LessonResponseModel.fromJson(e))
                .toList();
          }
      }
    } on DioError catch (e) {
      print("e");
    }
  }
}
