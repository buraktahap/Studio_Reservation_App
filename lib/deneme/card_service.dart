import 'dart:html';

import 'package:dio/dio.dart';
import 'package:studio_reservation_app/classes/lesson.dart';
import 'package:studio_reservation_app/classes/pagination_mode.dart';
import 'package:studio_reservation_app/core/enums/url_enum.dart';
import 'package:studio_reservation_app/deneme/card_service_interface.dart';

class CardService extends CardServiceInterface {
  late Dio _dio;

  CardService() {
    _dio = Dio();
  }

  @override
  Future<List<Lesson>> fetchCards(PaginationModel paginate) async {
    var queryParameters = {"page": paginate.page, "limit": paginate.limit};
    try {
      var response = await _dio.get(
        Urls.GetAllLessons.rawValue,
        queryParameters: queryParameters,
      );

      return response.data.map((e) => Lesson.fromJson(e)).toList().cast<Lesson>() as List<Lesson>;
    } catch (e) {
      return [];
    }
  }
}