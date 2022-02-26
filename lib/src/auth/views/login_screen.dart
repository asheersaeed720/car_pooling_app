import 'package:async_button_builder/async_button_builder.dart';
import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:car_pooling_app/src/auth/views/forgot_password_screen.dart';
import 'package:car_pooling_app/src/auth/views/signup_screen.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/utils/input_decoration.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LogInScreen extends StatelessWidget {
  static const String routeName = '/login';

  LogInScreen({Key? key}) : super(key: key);

  final _authController = Get.find<AuthController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.black.withOpacity(0.5)),
        child: ListView(
          children: [
            _buildHeaderView(context),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildEmailTextField(context),
                    const SizedBox(height: 10.0),
                    _buildPasswordTextField(context),
                    const SizedBox(height: 10.0),
                    CustomAsyncBtn(
                      btntxt: 'LOGIN',
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          _authController.isLoading = true;
                          await _authController.handleLogIn().catchError((_) {
                            _authController.isLoading = false;
                            _authController.update();
                          });
                          _authController.isLoading = false;
                          _authController.update();
                        }
                      },
                    ),
                    const SizedBox(height: 16.0),
                    _buildExtraDataView(context),
                    const SizedBox(height: 16.0),
                    _buildDividerView(),
                    const SizedBox(height: 24.0),
                    _buildSocialMediaBtnView(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/car_pooling.jpg"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.7),
            // gradient: LinearGradient(
            //   begin: FractionalOffset.topCenter,
            //   end: FractionalOffset.bottomCenter,
            //   colors: [
            //     primaryColor.withOpacity(0.4),
            //     primaryColor,
            //   ],
            //   stops: const [0.0, 1.0],
            // ),
          ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: [
          //     Image.asset(
          //       'assets/images/dummy_logo.png',
          //       height: MediaQuery.of(context).size.height * 0.2,
          //     ),
          //   ],
          // ),
        ),
      ],
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
        } /*else if (_authController.userFormModel.password.length < 6) {
          return 'Too short';
        }*/
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

  Widget _buildExtraDataView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Get.toNamed(SignUpScreen.routeName),
          child: RichText(
            text: const TextSpan(
              text: 'New User?',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: ' Sign up',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => Get.toNamed(ForgotPasswordScreen.routeName),
          child: RichText(
            text: const TextSpan(
              text: 'Forgot',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: ' Password?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDividerView() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.grey.shade100,
                  Colors.grey,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: const <double>[0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            width: 60.0,
            height: 1.0,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              'OR CONTINUE WITH',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.grey,
                  Colors.grey.shade100,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: const <double>[0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            width: 60.0,
            height: 1.0,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaBtnView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: AsyncButtonBuilder(
            child: Row(
              children: [
                Image.asset('assets/icons/facebook.png', width: 22.0),
                const SizedBox(width: 22.0),
                Text(
                  'Facebook',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            onPressed: () async {},
            showSuccess: false,
            errorWidget: const Text('error'),
            builder: (context, child, callback, _) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 2.4,
                height: 48.0,
                child: ElevatedButton(
                  child: child,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFF486CB4)),
                    elevation: MaterialStateProperty.all(0.0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  onPressed: callback,
                ),
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: AsyncButtonBuilder(
            child: Row(
              children: [
                Image.asset('assets/icons/google.png', width: 22.0),
                const SizedBox(width: 22.0),
                Text(
                  'Google',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            onPressed: () async {},
            showSuccess: false,
            errorWidget: const Text('error'),
            builder: (context, child, callback, _) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 2.4,
                height: 48.0,
                child: ElevatedButton(
                  child: child,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    elevation: MaterialStateProperty.all(0.0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  onPressed: callback,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
