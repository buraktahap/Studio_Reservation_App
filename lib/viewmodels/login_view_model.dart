import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import '../core/base/base_viewmodel.dart';
import '../core/constants/network/network_constants.dart';
import '../core/enums/url_enum.dart';
import '../models/sign_in_model.dart';
import '../models/sign_in_response.dart';
import 'package:path/path.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    super.init();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isChecked = false;
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  @observable
  bool isLoading = false;
  @observable
  bool isLockOpen = true;
  @observable
  String userEmail = "";
  @observable
  bool isVisible = true;
  @observable
  int currentTabIndex = 0;
  @action
  void setUserEmail(String email) {
    userEmail = email;
  }

  @action
  void changeVisibility() {
    isVisible = !isVisible;
  }

  @action
  void changeCurrentTabIndex(int val) {
    currentTabIndex = val;
  }

  @action
  void isLockStateChange() {
    isLockOpen = !isLockOpen;
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstants.BASE_URL,
      headers: {"Content-Type": "application/json"},
    ),
  );
  Future<String?> signIn(String email, String password) async {
    try {
      final response = await dio.post(
        Urls.SignIn.rawValue,
        data: json.encode(SignInModel(
                email: emailController.text, password: passwordController.text)
            .toJson()),
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
          final SignInResponse appSignInResponse =
              SignInResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }
}
