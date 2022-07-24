import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/components/input_field.dart';
import '../../../../core/base/view/base_view.dart';
import '../components/logo.dart';
import '../components/password_field.dart';
import '../viewmodels/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

final _formKey = GlobalKey<FormState>();

class _LoginViewState extends State<LoginView> with RouteAware {
  void didPopNext() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      viewModel: LoginViewModel(),
      onModelReady: (LoginViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, LoginViewModel viewModel) =>
          Scaffold(
        body: Observer(builder: (_) {
          return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Background(
                      child: SafeArea(
                          child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Align(
                                alignment: Alignment.centerLeft, child: Logo()),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: const Text("SIGN IN",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Quicksand',
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 17, 0, 13),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: littleLine(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "I am alone, and feel the charm of existence in this spot, which was created for mine. ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.7),
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Quicksand',
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 49,
                          ),
                          InputField(
                              controller: viewModel.emailController,
                              hint: "Email Adress"),
                          const SizedBox(height: 20),
                          PasswordField(
                            controller: viewModel.passwordController,
                            hint: "Password",
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forget Password?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          ColoredButton(
                            text: 'Sign In',
                            onPressed: () async {
                              _formKey.currentState!.save();
                              final isValid = _formKey.currentState!.validate();
                              print(isValid);
                              if (isValid) {
                                await viewModel.signIn(
                                  viewModel.emailController.text,
                                  viewModel.passwordController.text,
                                );
                              } else {
                                const snackBar = SnackBar(
                                  content: Text(
                                      "Lütfen E-posta ve Şifre Alanlarını Doldurunuz"),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have an account?',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal)),
                                  const Text('Sign Up Now!',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          )
                        ],
                      )),
                    ),
                  )));
        }),
      ),
    );
  }

  Container littleLine() {
    return Container(
      width: 50.0,
      height: 2.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: const LinearGradient(
          begin: Alignment(0.9999982118745121, 0.999980688244732),
          end: Alignment(0.9999982118745121, -1.0000038146677073),
          stops: [0.0, 1.0],
          colors: [
            Color.fromARGB(255, 253, 12, 146),
            Color.fromARGB(255, 255, 170, 146)
          ],
        ),
      ),
    );
  }
}
