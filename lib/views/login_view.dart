import 'package:flutter/material.dart';
import 'package:studio_reservation_app/components/colored_button.dart';
import 'package:studio_reservation_app/components/input_field.dart';
import '../../../../core/base/view/base_view.dart';
import '../components/logo.dart';
import '../components/password_field.dart';
import '../core/constants/enums/preferences_keys_enum.dart';
import '../core/init/cache/locale_manager.dart';
import '../viewmodels/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  bool isRememberMeCheckBox = false;
  @override
  Widget build(BuildContext context) {
    // bool? isRememberme =

    //     LocaleManager.instance.getBoolValue(PreferencesKeys.isRememberMe);
    return BaseView<LoginViewModel>(
      viewModel: LoginViewModel(),
      onModelReady: (LoginViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, LoginViewModel viewModel) =>
          Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                clipBehavior: Clip.antiAlias,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                // reverse: true,
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: IntrinsicHeight(
                      child: SignInBackground(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Logo()),
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
                                      fontWeight: FontWeight.normal,
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
                              padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                    "I am alone, and feel the charm of existence in this spot, which was created for mine. ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 49,
                            ),
                            InputField(
                              controller: viewModel.emailController,
                              hint: "Email Adress",
                              icon: const Icon(
                                Icons.mail_outline_rounded,
                                color: Color(0xffFD0C89),
                              ),
                            ),
                            const SizedBox(height: 20),
                            PasswordField(
                              controller: viewModel.passwordController,
                              hint: "Password",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Remember Me?',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Checkbox(
                                      activeColor: const Color(0xffFD0C89),
                                      value: isRememberMeCheckBox,
                                      onChanged: ((value) {
                                        setState(() {
                                          isRememberMeCheckBox =
                                              !isRememberMeCheckBox;
                                          LocaleManager.instance.setBoolValue(
                                              PreferencesKeys.isRememberMe,
                                              value!);
                                        });
                                      })),
                                ],
                              ),
                            ),
                            ColoredButton(
                              text: 'Sign In',
                              onPressed: () async {
                                if (isRememberMeCheckBox == true) {
                                  LocaleManager.instance.setBoolValue(
                                      PreferencesKeys.isRememberMe,
                                      isRememberMeCheckBox);
                                }
                                viewModel.signIn(
                                  viewModel.emailController.text,
                                  viewModel.passwordController.text,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    )),
              )),
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

class SignInBackground extends StatelessWidget {
  const SignInBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/backgroundLight.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
