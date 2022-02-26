import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:car_pooling_app/src/auth/header_widget.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:car_pooling_app/widgets/custom_text_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign-up';

  SignUpScreen({Key? key}) : super(key: key);

  final _authController = Get.find<AuthController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const HeaderWidget(isSignUpScreen: true),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _firstNameController,
                    prefixIcon: Icons.person,
                    hintText: 'First name',
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: _lastNameController,
                    prefixIcon: Icons.person,
                    hintText: 'Last name',
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: _emailController,
                    prefixIcon: Icons.email,
                    hintText: 'Email',
                    isEmail: true,
                  ),
                  const SizedBox(height: 10.0),
                  _buildPhoneNoFieldView(context),
                  GenderSelector(_genderController.text),
                  const SizedBox(height: 10.0),
                  _buildDateOfBirthView(context),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: _passwordController,
                    prefixIcon: Icons.lock,
                    hintText: 'Password',
                    isPassword: true,
                    isShowSuffixIcon: true,
                  ),
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
                        await _authController
                            .handleSignUp(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          email: _emailController.text,
                          phoneNo: _phoneNoController.text,
                          dateOfBirth: _genderController.text,
                          gender: _dateOfBirthController.text,
                          password: _passwordController.text,
                        )
                            .catchError((_) {
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
    );
  }

  Widget _buildPhoneNoFieldView(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: 'Phone No',
        hintStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(style: BorderStyle.none, width: 0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required Field';
        }
        return null;
      },
      controller: _phoneNoController,
      initialCountryCode: 'PK',
      // onChanged: (phone) {
      //   log(phone.completeNumber);
      // },
    );
  }

  Widget _buildDateOfBirthView(BuildContext context) {
    return DateTimeField(
      format: DateFormat.yMMMEd(),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.date_range),
        contentPadding: const EdgeInsets.all(10),
        hintText: 'Date of Birth',
        hintStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(style: BorderStyle.none, width: 0),
        ),
      ),
      validator: (value) {
        if (value == null) {
          return 'Required Field';
        }
        return null;
      },
      controller: _dateOfBirthController,
      // onChanged: (value) {
      //   userFormModel.dateOfBirth?.text = '$value';
      // },
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
}

// ignore: must_be_immutable
class GenderSelector extends StatelessWidget {
  GenderSelector(this.whichGender, {Key? key}) : super(key: key);
  String whichGender;

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
            itemCount: _authController.gendersList.length,
            itemBuilder: (context, index) {
              return GetBuilder<AuthController>(
                builder: (_) => InkWell(
                  splashColor: primaryColor,
                  onTap: () {
                    for (var gender in _authController.gendersList) {
                      gender.isSelected = false;
                    }
                    whichGender = _authController.gendersList[index].name;
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
