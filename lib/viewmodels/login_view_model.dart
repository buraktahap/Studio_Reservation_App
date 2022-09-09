import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/core/base/model/base_viewmodel.dart';
import 'package:studio_reservation_app/views/location_selection_view.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/constants/network/network_constants.dart';
import '../core/enums/url_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../models/sign_in_model.dart';
import '../models/sign_in_response.dart';
import 'dart:async';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  late TextEditingController emailController;
  late TextEditingController passwordController;

  final dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      headers: {"Content-Type": "application/json"},
    ),
  );

  @observable
  Future<String?> signIn(String email, String password) async {
    try {
      final response = await dio.post(
        Urls.signIn.rawValue,
        data: json.encode(SignInModel(
                email: emailController.text, password: passwordController.text)
            .toJson()),
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
          final SignInResponseModel appSignInResponse =
              SignInResponseModel.fromJson(response.data);
          await LocaleManager.instance
              .setIntValue(PreferencesKeys.userId, appSignInResponse.id as int);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const LocationSelectionView()),
              (r) => false);

          break;
        case HttpStatus.notFound:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Invalid email or password"),
          ));
          break;
      }
    } on DioError {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter registered email and password")));
    }
    return null;
  }

  @action
  getCities() {
    return cities;
  }

  @observable
  List cities = [];
}
