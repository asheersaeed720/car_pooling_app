import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isShowSuffixIcon;
  final IconData? prefixIcon;
  final Function? onTap;
  final Function? onChanged;
  final Function? onSuffixTap;
  final String? suffixIconUrl;
  final String? prefixIconUrl;
  final bool isSearch;
  final Function? onSubmit;
  final bool isEnabled;
  final bool isEmail;

  final TextCapitalization capitalization;
  final bool required;

  const CustomTextField({
    Key? key,
    this.hintText = 'Write something...',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSuffixTap,
    this.onSubmit,
    this.onChanged,
    this.capitalization = TextCapitalization.none,
    this.isCountryPicker = false,
    this.isShowBorder = false,
    this.isShowSuffixIcon = false,
    this.prefixIcon,
    this.onTap,
    this.isPassword = false,
    this.isEmail = false,
    this.suffixIconUrl,
    this.prefixIconUrl,
    this.isSearch = false,
    this.required = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) => TextFormField(
        maxLines: maxLines,
        controller: controller,
        focusNode: focusNode,
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 16),
        textInputAction: inputAction,
        keyboardType: inputType,
        textCapitalization: capitalization,
        enabled: isEnabled,
        validator: (value) {
          if (isEmail) {
            if (value == null || value.isEmpty) {
              return 'Required Field';
            }
            bool emailValid =
                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
            return !emailValid ? "Enter Valid Email" : null;
          } else {
            if (required && (value == null || value.isEmpty)) {
              return 'Required Field';
            }
          }
          return null;
        },
        autofocus: false,
        obscureText: isPassword ? authController.obscureText : false,
        inputFormatters: isEmail
            ? [
                FilteringTextInputFormatter.deny(RegExp(' ')),
              ]
            : [],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 22.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(style: BorderStyle.none, width: 0),
          ),
          isDense: true,
          hintText: hintText,
          prefixIcon: prefixIcon == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(prefixIcon, size: 22.0),
                ),
          suffixIcon: isShowSuffixIcon
              ? isPassword
                  ? IconButton(
                      icon: Icon(
                        authController.obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3),
                        size: 22.0,
                      ),
                      onPressed: authController.togglePw,
                    )
                  : null
              : null,
        ),
        onTap: onTap as void Function()?,
        onChanged: onChanged as void Function(String)?,
      ),
    );
  }
}
