import 'dart:developer';

import 'package:car_pooling_app/src/auth/models/user.dart';
import 'package:car_pooling_app/utils/api.dart';
import 'package:get/get.dart';

class AuthService extends GetConnect {
  Future<Response> logInUser(UserModel user) async {
    var loginFormData = FormData({
      'login': user.email,
      'password': user.password,
    });
    log(user.email);
    log(user.password);
    return post('$apiURL/Auth/login', loginFormData, contentType: 'form-data');
  }

  Future<Response> signUpUser(UserModel user) async {
    var signUpFormData = FormData({
      'first_name': user.firstName,
      'last_name': user.lastName,
      'email': user.email,
      'birth_year': user.dateOfBirth,
      'gender': user.gender,
      'password': user.password,
    });
    return post('$apiURL/Auth/signup', signUpFormData, contentType: 'form-data');
  }
}
