import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

class _LoginViewState extends State<LoginView> {
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
        resizeToAvoidBottomInset: false,
        body: Observer(builder: (_) {
          return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: SignInBackground(
                      child: SafeArea(
                          child: Column(
                        children: [
                          const SizedBox(height: 20),
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
                              viewModel.signIn(
                                viewModel.emailController.text,
                                viewModel.passwordController.text,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          // Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text('Don\'t have an account?',
                          //           style: TextStyle(
                          //               color: Colors.white.withOpacity(0.7),
                          //               fontSize: 16,
                          //               fontWeight: FontWeight.normal)),
                          //       SizedBox(width: 10),
                          //       const Text('Sign Up Now!',
                          //           style: TextStyle(
                          //               color: Colors.white,
                          //               fontSize: 16,
                          //               fontWeight: FontWeight.bold)),
                          //     ])
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

class SignInBackground extends StatelessWidget {
  const SignInBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/sign_in_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
