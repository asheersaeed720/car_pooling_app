import 'package:car_pooling_app/src/auth/views/forgot_password_screen.dart';
import 'package:car_pooling_app/src/auth/views/login_screen.dart';
import 'package:car_pooling_app/src/auth/views/signup_screen.dart';
import 'package:car_pooling_app/src/chat/views/chat_detail_screen.dart';
import 'package:car_pooling_app/src/tab_screen.dart';
import 'package:get/get.dart';

import '../src/home/views/home_detail_screen.dart';

final List<GetPage<dynamic>> routes = [
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
    name: TabScreen.routeName,
    page: () => const TabScreen(),
  ),
  GetPage(
    name: HomeDetailScreen.routeName,
    page: () => const HomeDetailScreen(),
  ),
  GetPage(
    name: ChatDetailScreen.routeName,
    page: () => const ChatDetailScreen(),
  ),
];
