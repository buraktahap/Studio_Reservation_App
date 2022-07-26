import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/core/base/model/base_viewmodel.dart';
import 'package:studio_reservation_app/models/member_details_response.dart';

import '../core/constants/network/network_constants.dart';
import '../core/enums/url_enum.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  final dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      headers: {"Content-Type": "application/json"},
    ),
  );

  @observable
  Future<MemberDetailsResponse?> memberDetails(int id) async {
    try {
      final response = await dio
          .get(Urls.getMemberById.rawValue, queryParameters: {'id': id});
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = await response.data;
          MemberDetailsResponse memberDetailsResponse =
              MemberDetailsResponse.fromJson(responseBody);
          return memberDetailsResponse;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
