import 'dart:developer';

import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/utils/input_decoration.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign-up';

  SignUpScreen({Key? key}) : super(key: key);

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
                    _buildFirstNameTextField(context),
                    const SizedBox(height: 10.0),
                    _buildLastNameTextField(context),
                    const SizedBox(height: 10.0),
                    _buildEmailTextField(context),
                    const SizedBox(height: 10.0),
                    _buildPhoneNoFieldView(context),
                    GenderSelector(),
                    const SizedBox(height: 10.0),
                    _buildDateOfBirthView(context),
                    const SizedBox(height: 10.0),
                    _buildPasswordTextField(context),
                    const SizedBox(height: 10.0),
                    CustomAsyncBtn(
                      btntxt: 'SIGN UP NOW',
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          _authController.isLoading = true;
                          await _authController.handleSignUp().catchError((_) {
                            _authController.isLoading = false;
                            _authController.update();
                          });
                          _authController.isLoading = false;
                          _authController.update();
                        }
                      },
                    ),
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
        Positioned(
          top: 6.0,
          left: 8.0,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 6.0),
              Text(
                'SIGN UP',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFirstNameTextField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onChanged: (value) {
        _authController.userFormModel.firstName =
            value.replaceAll(RegExp(r"\s+\b|\b\s"), " ").trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      decoration: buildTextFieldInputDecoration(
        context,
        preffixIcon: Icons.person_outline_outlined,
        hintTxt: 'First Name',
      ),
    );
  }

  Widget _buildLastNameTextField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onChanged: (value) {
        _authController.userFormModel.lastName =
            value.replaceAll(RegExp(r"\s+\b|\b\s"), " ").trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      decoration: buildTextFieldInputDecoration(
        context,
        preffixIcon: Icons.person_outline_outlined,
        hintTxt: 'Last Name',
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

  Widget _buildPhoneNoFieldView(BuildContext context) {
    return IntlPhoneField(
      decoration: buildTextFieldInputDecoration(context, hintTxt: 'Phone No'),
      initialCountryCode: 'PK',
      onChanged: (phone) {
        log(phone.completeNumber);
      },
    );
  }

  Widget _buildDateOfBirthView(BuildContext context) {
    return DateTimeField(
      format: DateFormat.yMMMEd(),
      decoration: buildTextFieldInputDecoration(
        context,
        preffixIcon: Icons.date_range,
        hintTxt: 'Date of birth',
      ),
      onChanged: (value) {
        _authController.userFormModel.dateOfBirth = '$value';
      },
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
        );
      },
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

class GenderSelector extends StatelessWidget {
  GenderSelector({Key? key}) : super(key: key);

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Select Gender',
          style: kTitleStyle,
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 80.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // shrinkWrap: true,
            itemCount: _authController.gendersList.length,
            itemBuilder: (context, index) {
              return GetBuilder<AuthController>(
                builder: (_) => InkWell(
                  splashColor: primaryColor,
                  onTap: () {
                    for (var gender in _authController.gendersList) {
                      gender.isSelected = false;
                    }
                    _authController.gendersList[index].isSelected = true;
                    _authController.update();
                  },
                  child: Card(
                    color:
                        _authController.gendersList[index].isSelected ? primaryColor : Colors.white,
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width / 4.2,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            _authController.gendersList[index].icon,
                            color: _authController.gendersList[index].isSelected
                                ? Colors.white
                                : Colors.grey,
                            size: 32,
                          ),
                          // const SizedBox(height: 8),
                          Text(
                            _authController.gendersList[index].name,
                            style: TextStyle(
                              color: _authController.gendersList[index].isSelected
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
