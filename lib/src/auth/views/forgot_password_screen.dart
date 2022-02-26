import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:car_pooling_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot-pw';

  ForgotPasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password'),
        elevation: 0,
        // backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GetBuilder<AuthController>(
                builder: (_) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/forgot_pw.png', width: 182.0),
                    const SizedBox(height: 18.0),
                    Text('Password reset!', style: kTitleStyle),
                    const Text('This action will send password at your email.'),
                    const SizedBox(height: 18.0),
                    const CustomTextField(
                      hintText: 'Email',
                      isEmail: true,
                    ),
                    const SizedBox(height: 18.0),
                    CustomAsyncBtn(
                      btntxt: 'Submit',
                      onPress: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
