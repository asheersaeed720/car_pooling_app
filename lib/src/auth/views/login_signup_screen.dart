import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LogInScreen extends StatelessWidget {
  static const String routeName = '/login';

  const LogInScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Car Pooling',
      logo: const AssetImage('assets/images/logo.png'),
      onLogin: (value) {
        log('$value');
        // Get.toNamed(HomeScreen.routeName);
        return null;
      },
      onSignup: (value) {
        // Get.toNamed(HomeScreen.routeName);
        return null;
      },
      // loginProviders: <LoginProvider>[
      //   LoginProvider(
      //     icon: FontAwesomeIcons.google,
      //     label: 'Google',
      //     callback: () async {
      //       debugPrint('start google sign in');
      //       await Future.delayed(loginTime);
      //       debugPrint('stop google sign in');
      //       return null;
      //     },
      //   ),
      //   LoginProvider(
      //     icon: FontAwesomeIcons.facebookF,
      //     label: 'Facebook',
      //     callback: () async {
      //       debugPrint('start facebook sign in');
      //       await Future.delayed(loginTime);
      //       debugPrint('stop facebook sign in');
      //       return null;
      //     },
      //   ),
      //   LoginProvider(
      //     icon: FontAwesomeIcons.linkedinIn,
      //     callback: () async {
      //       debugPrint('start linkdin sign in');
      //       await Future.delayed(loginTime);
      //       debugPrint('stop linkdin sign in');
      //       return null;
      //     },
      //   ),
      //   LoginProvider(
      //     icon: FontAwesomeIcons.githubAlt,
      //     callback: () async {
      //       debugPrint('start github sign in');
      //       await Future.delayed(loginTime);
      //       debugPrint('stop github sign in');
      //       return null;
      //     },
      //   ),
      // ],
      onSubmitAnimationCompleted: () {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => DashboardScreen(),
        // ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
