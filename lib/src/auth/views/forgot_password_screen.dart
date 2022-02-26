import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/utils/input_decoration.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
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
                    TextFormField(
                      initialValue: _authController.userFormModel.email,
                      onChanged: (value) {
                        _authController.userFormModel.email = value;
                      },
                      validator: (value) {
                        bool isValidEmail = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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

  Widget _buildEmailTextField(context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        autofocus: true,
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
          hintTxt: 'Email',
          preffixIcon: Icons.email,
        ),
      ),
    );
  }
}
