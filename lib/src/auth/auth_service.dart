import 'dart:developer';

import 'package:car_pooling_app/utils/api.dart';
import 'package:get/get.dart';

class AuthService extends GetConnect {
  Future<Response> logInUser(String email, String password) async {
    var loginFormData = FormData({
      'login': email,
      'password': password,
    });
    log(email);
    log(password);
    return post('$apiURL/Auth/login', loginFormData, contentType: 'form-data');
  }

  Future<Response> signUpUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNo,
    required String dateOfBirth,
    required String gender,
    required String password,
  }) async {
    var signUpFormData = FormData({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_no': phoneNo,
      'birth_year': dateOfBirth,
      'gender': gender,
      'password': password,
    });
    log('$signUpFormData');
    return post('$apiURL/Auth/signup', signUpFormData, contentType: 'form-data');
  }
}
