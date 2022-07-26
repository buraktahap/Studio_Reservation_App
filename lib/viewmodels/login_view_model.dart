import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:studio_reservation_app/views/location_selection_view.dart';
import '../core/base/base_viewmodel.dart';
import '../core/constants/network/network_constants.dart';
import '../core/enums/url_enum.dart';
import '../models/sign_in_model.dart';
import '../models/sign_in_response.dart';
import 'dart:async';

import 'package:http/http.dart' as http;

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
          final SignInResponse appSignInResponse = await
              SignInResponse.fromJson(response.data);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LocationSelectionView()));
          break;
        case HttpStatus.notFound:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Invalid email or password"),
          ));
          break;
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please enter registered email and password")));
    }
    return null;
  }

  // Future<void> login() async {
  //   if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
  //     var response = await http.post(
  //         Uri.parse("https://192.168.1.38:7240/api/Member/LoginRequest"),
  //         body: ({
  //           'email': "admin@test.com",
  //           'password': passwordController.text
  //         }));
  //     if (response.statusCode == 200) {
  //       print("giriş başarılı");
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => LocationSelectionView()));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("Invalid Credentials.")));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Black Field Not Allowed")));
  //   }
  // }
}
