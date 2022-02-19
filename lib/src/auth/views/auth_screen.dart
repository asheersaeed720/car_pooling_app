import 'package:car_pooling_app/src/home/views/home_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
    // return GetBuilder<AuthController>(
    //   builder: (authController) {
    //     log('${authController.currentUserData}', name: 'AuthScreen');
    //     if (authController.currentUserData.isEmpty) {
    //       return const LogInSignUpScreen();
    //     }
    //     return const HomeScreen();
    //   },
    // );
  }
}
