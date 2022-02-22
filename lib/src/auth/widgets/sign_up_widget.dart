import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:car_pooling_app/utils/input_decoration.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Form(
        key: _authController.signUpFormKey,
        child: Column(
          children: [
            _buildFirstNameTextField(context),
            const SizedBox(height: 4.0),
            _buildLastNameTextField(context),
            const SizedBox(height: 4.0),
            _buildEmailTextField(context),
            const SizedBox(height: 4.0),
            _buildDateOfBirthView(),
            const SizedBox(height: 4.0),
            _buildGenderSelectionView(),
            _buildPasswordTextField(context),
            const SizedBox(height: 22.0),
            // Container(
            //   width: 200,
            //   margin: const EdgeInsets.only(top: 20),
            //   child: RichText(
            //     textAlign: TextAlign.center,
            //     text: const TextSpan(
            //       text: "By pressing 'Submit' you agree to our ",
            //       style: TextStyle(color: Colors.black87),
            //       children: [
            //         TextSpan(
            //           text: "Term & Conditions",
            //           style: TextStyle(color: Colors.orange),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstNameTextField(BuildContext context) {
    return TextFormField(
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
        hintTxt: 'First name',
      ),
    );
  }

  Widget _buildLastNameTextField(BuildContext context) {
    return TextFormField(
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
        hintTxt: 'Last name',
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

  Widget _buildDateOfBirthView() {
    return DateTimeField(
      format: DateFormat.yMMMEd(),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
        );
      },
      validator: (value) {
        if (value == null) {
          return 'Required';
        }
        return null;
      },
      decoration: buildTextFieldInputDecoration(
        context,
        preffixIcon: Icons.date_range,
        hintTxt: 'Date of birth',
      ),
    );
  }

  Widget _buildGenderSelectionView() {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () => _authController.selectGender('male'),
            leading: Radio<String>(
              value: 'male',
              groupValue: _authController.gender,
              onChanged: (String? value) {
                _authController.selectGender(value);
              },
            ),
            title: const Text(
              'male',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () => _authController.selectGender('female'),
            leading: Radio<String>(
              value: 'female',
              groupValue: _authController.gender,
              onChanged: (String? value) {
                _authController.selectGender(value);
              },
            ),
            title: const Text(
              'female',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ],
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
