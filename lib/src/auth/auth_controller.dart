import 'dart:developer';

import 'package:car_pooling_app/src/auth/auth_service.dart';
import 'package:car_pooling_app/src/auth/user.dart';
import 'package:car_pooling_app/src/auth/views/auth_screen.dart';
import 'package:car_pooling_app/src/network_manager.dart';
import 'package:car_pooling_app/utils/custom_snack_bar.dart';
import 'package:car_pooling_app/utils/display_toast_message.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends NetworkManager {
  final _authService = Get.find<AuthService>();

  final UserModel userFormModel = UserModel();

  final GetStorage _getStorage = GetStorage();

  Map currentUserData = {};

  bool isLoading = false;

  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newObscureVal) {
    _obscureText = newObscureVal;
    update();
  }

  String rememberEmail = '';

  bool isRememberMe = false;

  @override
  void onInit() {
    currentUserData = getCurrentUser();
    rememberEmail = _getStorage.read('email') ?? '';
    super.onInit();
  }

  Future<void> handleLogIn() async {
    if (connectionType != 0) {
      try {
        var response = await _authService.logInUser(userFormModel);
        if (response.statusCode == 200) {
          _getStorage.write(
            'user',
            {
              'key': "${response.body['key']}",
              ...response.body['user'],
            },
          );
          currentUserData = getCurrentUser();
          if (isRememberMe) {
            _getStorage.write('email', userFormModel.email);
            rememberEmail = _getStorage.read('email');
          }
          update();
          Get.offAllNamed(AuthScreen.routeName);
        } else if (response.statusCode == 404) {
          displayToastMessage('Invalid Credentials');
        } else {
          displayToastMessage('Something went wrong');
        }
        log('loginRes ${response.body}, type:${response.body.runtimeType}');
      } catch (e) {
        displayToastMessage(e);
        rethrow;
      }
    } else {
      customSnackBar('Network error', 'Please try again later');
    }
  }

  Future<void> handleSignUp() async {
    if (connectionType != 0) {
      try {
        var response = await _authService.signUpUser(userFormModel);
        if (response.statusCode == 200) {
          _getStorage.write(
            'user',
            {
              'key': "${response.body['key']}",
              ...response.body['user'],
            },
          );
          currentUserData = getCurrentUser();
          update();
          Get.offAllNamed(AuthScreen.routeName);
        } else if (response.statusCode == 404) {
          displayToastMessage('Invalid Credentials');
        } else {
          displayToastMessage('Something went wrong');
        }
        log('signUpRes ${response.body}, type:${response.body.runtimeType}');
      } catch (e) {
        displayToastMessage(e);
        rethrow;
      }
    } else {
      customSnackBar('Network error', 'Please try again later');
    }
  }

  Map getCurrentUser() {
    Map userData = _getStorage.read('user') ?? {};
    if (userData.isNotEmpty) {
      Map user = userData;
      log('$userData', name: 'storeUser');
      return user;
    } else {
      return {};
    }
  }

  logoutUser() {
    _getStorage.remove('user');
    currentUserData = _getStorage.read('user') ?? {};
    update();
    displayToastMessage('Logout');
    Get.offAllNamed(AuthScreen.routeName);
  }
}
