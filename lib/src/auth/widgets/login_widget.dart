import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/utils/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({Key? key}) : super(key: key);

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Form(
        key: _authController.logInFormKey,
        child: Column(
          children: [
            _buildEmailTextField(context),
            const SizedBox(height: 4.0),
            _buildPasswordTextField(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _authController.isRememberMe,
                      // activeColor: textColor2,
                      onChanged: (value) {
                        _authController.isRememberMe = !_authController.isRememberMe;
                        _authController.update();
                      },
                    ),
                    const Text("Remember me", style: TextStyle(fontSize: 12, color: textColor1))
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Get.toNamed(ForgotPasswordScreen.routeName);
                  },
                  child: const Text("Forgot Password?",
                      style: TextStyle(fontSize: 12, color: textColor1)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    if (_authController.rememberEmail.isNotEmpty) {
      _authController.userFormModel.email = _authController.rememberEmail;
    }
    return TextFormField(
      initialValue: _authController.userFormModel.email,
      onChanged: (value) {
        _authController.userFormModel.email = value;
      },
      validator: (value) {
        bool isValidEmail =
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch('$value');
        if (value!.isEmpty) {
          return 'Required';
        } else if (!isValidEmail) {
          return 'Invalid Email';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: buildTextFieldInputDecoration(
        context,
        preffixIcon: Icons.email_outlined,
        hintTxt: 'Email',
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        _authController.userFormModel.password = value;
      },
      obscureText: _authController.obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required';
        } else if (_authController.userFormModel.password.length < 6) {
          return 'Too short';
        }
        return null;
      },
      keyboardType: TextInputType.visiblePassword,
      decoration: buildPasswordInputDecoration(
        context,
        suffixIcon: GestureDetector(
          onTap: () {
            _authController.obscureText = !_authController.obscureText;
          },
          child: Icon(
            _authController.obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        hintTxt: 'Password',
        preffixIcon: Icons.lock_open_outlined,
      ),
    );
  }
}
