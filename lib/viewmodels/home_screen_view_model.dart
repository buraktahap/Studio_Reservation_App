import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/models/lesson_response_model.dart';
import 'package:studio_reservation_app/models/member_details_response.dart';

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

  // @observable
  // void checkInLessonDetails() async {
  //   try {
  //     final response =
  //         await dio.get(Urls.CheckInLessonDetails.rawValue, queryParameters: {
  //       'id': userId,
  //     });
  //     switch (response.statusCode) {
  //       case HttpStatus.ok:
  //         final responseBody = await response.data;
  //         print(responseBody);
  //         final checkInLessonDetails = responseBody
  //             .map((e) => memberLessonResponse.fromJson(e))
  //             .toList();
  //         print(checkInLessonDetails[0].lessonId);

  //         await LocaleManager.instance
  //             .setIntValue(PreferencesKeys.CHECKIN_ID,checkInLessonDetails[0].lessonId );
  //     }
  //   } on DioError catch (e) {
  //     print("e");
  //   }
  //   return null;
  // }

  final int? checkInId =
      LocaleManager.instance.getIntValue(PreferencesKeys.CHECKIN_ID);
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
