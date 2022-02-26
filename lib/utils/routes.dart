import 'package:car_pooling_app/src/auth/views/auth_screen.dart';
import 'package:car_pooling_app/src/auth/views/forgot_password_screen.dart';
import 'package:car_pooling_app/src/auth/views/login_screen.dart';
import 'package:car_pooling_app/src/auth/views/signup_screen.dart';
import 'package:car_pooling_app/src/home/views/home_screen.dart';
import 'package:get/get.dart';

import '../src/home/views/home_detail_screen.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(
    name: AuthScreen.routeName,
    page: () => const AuthScreen(),
  ),
  GetPage(
    name: LogInScreen.routeName,
    page: () => LogInScreen(),
  ),
  GetPage(
    name: SignUpScreen.routeName,
    page: () => SignUpScreen(),
  ),
  GetPage(
    name: ForgotPasswordScreen.routeName,
    page: () => ForgotPasswordScreen(),
  ),
  GetPage(
    name: HomeScreen.routeName,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: HomeDetailScreen.routeName,
    page: () => const HomeDetailScreen(),
  ),
];
