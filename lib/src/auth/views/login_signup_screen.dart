import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:car_pooling_app/src/auth/widgets/login_widget.dart';
import 'package:car_pooling_app/src/auth/widgets/sign_up_widget.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/loading_widget.dart';

class LogInSignUpScreen extends StatefulWidget {
  static const String routeName = '/login-signup';

  const LogInSignUpScreen({Key? key}) : super(key: key);

  @override
  _LogInSignUpScreenState createState() => _LogInSignUpScreenState();
}

class _LogInSignUpScreenState extends State<LogInSignUpScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (_) => Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/car_pooling.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 90, left: 20),
                  color: primaryColor.withOpacity(.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: !_authController.isSignupScreen ? "Welcome" : "Welcome to",
                            style: TextStyle(
                              fontSize: 22.0,
                              letterSpacing: 2,
                              color: Colors.yellow[700],
                            ),
                            children: [
                              TextSpan(
                                text: _authController.isSignupScreen ? " Car Pooling," : " Back,",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow[700],
                                ),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        _authController.isSignupScreen
                            ? "Sign Up to Continue"
                            : "Sign In to Continue",
                        style: const TextStyle(
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            buildBottomHalfContainer(true),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: 188.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height:
                    _authController.isSignupScreen ? MediaQuery.of(context).size.height * 0.6 : 250,
                padding: const EdgeInsets.all(12.0),
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _authController.isSignupScreen = false;
                              _authController.update();
                            },
                            child: Column(
                              children: [
                                Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        !_authController.isSignupScreen ? primaryColor : textColor1,
                                  ),
                                ),
                                if (!_authController.isSignupScreen)
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: primaryColor,
                                  )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _authController.isSignupScreen = true;
                              _authController.update();
                            },
                            child: Column(
                              children: [
                                Text(
                                  "SIGNUP",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        _authController.isSignupScreen ? primaryColor : textColor1,
                                  ),
                                ),
                                if (_authController.isSignupScreen)
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: primaryColor,
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                      if (_authController.isSignupScreen) const SignUpWidget(),
                      if (!_authController.isSignupScreen) const LogInWidget()
                    ],
                  ),
                ),
              ),
            ),
            buildBottomHalfContainer(false),
          ],
        ),
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      top: _authController.isSignupScreen ? 510 : 400,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 74,
          width: 74,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              if (showShadow)
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1.5,
                  blurRadius: 10,
                )
            ],
          ),
          child: !showShadow
              ? _authController.isLoading
                  ? const LoadingWidget()
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [primaryColor, primaryColor.withOpacity(0.8)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1))
                        ],
                      ),
                      child: InkWell(
                        onTap: () async {
                          // Get.toNamed(HomeScreen.routeName);
                          if (_authController.isSignupScreen) {
                            if (_authController.signUpFormKey.currentState!.validate()) {
                              _authController.signUpFormKey.currentState!.save();
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              _authController.isLoading = true;
                              await _authController.handleSignUp().catchError((_) {
                                _authController.isLoading = false;
                                _authController.update();
                              });
                              _authController.isLoading = false;
                              _authController.update();
                            }
                          } else {
                            // if (_formKeyLogin.currentState!.validate()) {
                            //   _formKeyLogin.currentState!.save();
                            //   FocusScopeNode currentFocus = FocusScope.of(context);
                            //   if (!currentFocus.hasPrimaryFocus) {
                            //     currentFocus.unfocus();
                            //   }
                            //   _authController.isLoading = true;
                            //   await _authController.handleLogIn().catchError((_) {
                            //     _authController.isLoading = false;
                            //     _authController.update();
                            //   });
                            //   _authController.isLoading = false;
                            //   _authController.update();
                            // }
                          }
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    )
              : const Center(),
        ),
      ),
    );
  }
}
