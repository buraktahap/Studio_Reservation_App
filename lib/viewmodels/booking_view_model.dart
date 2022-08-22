import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/core/constants/network/network_constants.dart';
import 'package:studio_reservation_app/core/enums/url_enum.dart';
import 'package:studio_reservation_app/models/enrollResponseModel.dart';
import 'package:studio_reservation_app/models/get_lessons_by_branc_by_enroll.dart';
import 'package:studio_reservation_app/models/member_details_response.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
part 'booking_view_model.g.dart';

class BookingViewModel = _BookingViewModelBase with _$BookingViewModel;

abstract class _BookingViewModelBase with Store {
  final int? userId =
      LocaleManager.instance.getIntValue(PreferencesKeys.USER_ID);

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
  Future<List<GetLessonsByBranchNameWithEnroll>?> LessonsByBranchName(
      String? Location) async {
    try {
      final response =
          await dio.post(Urls.LessonsByBranchName.rawValue, queryParameters: {
        'memberId': userId,
        'branchName': Location,
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
    } on DioError catch (e) {
      print("e");
    }
  }

  @observable
  Future Enroll( int lessonId) async {
    try {
      final response = await dio.post(Urls.Enroll.rawValue,
          data: json.encode(
              enrollResponseModel(memberId: userId, lessonId: lessonId)
                  .toJson()));
      switch (response.statusCode) {
        case HttpStatus.created:
          final responseBody = await response.data;
          MemberDetailsResponse memberDetailsResponse =
              await responseBody.map((e) => MemberDetailsResponse.fromJson(e));
          break;
      }
    } on DioError catch (e) {
      print("e");
      return null;
    }
  }
}
