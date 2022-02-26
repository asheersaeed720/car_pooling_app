import 'package:flutter/material.dart';

InputDecoration buildTextFieldInputDecoration(
  context, {
  required String hintTxt,
  IconData? preffixIcon,
}) {
  return InputDecoration(
    prefixIcon: Icon(preffixIcon),
    contentPadding: const EdgeInsets.all(10),
    hintText: hintTxt,
    hintStyle: const TextStyle(fontSize: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(style: BorderStyle.none, width: 0),
    ),
  );
}

InputDecoration buildPasswordInputDecoration(
  context, {
  required String hintTxt,
  required IconData preffixIcon,
  required Widget suffixIcon,
}) {
  return InputDecoration(
    prefixIcon: Icon(preffixIcon),
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.all(10),
    hintText: hintTxt,
    hintStyle: const TextStyle(fontSize: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(style: BorderStyle.none, width: 0),
    ),
  );
}
