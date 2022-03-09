import 'package:car_pooling_app/utils/constants.dart';
import 'package:flutter/material.dart';

filterModalBottomSheet(context) {
  final _formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (builder) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 14.0),
          Container(
            width: 62.0,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 4.0, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 24, left: 16),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/car_pooling.jpg',
                  width: 48.0,
                ),
                const SizedBox(width: 12.0),
                Text(
                  "Filter",
                  style: kTitleStyle,
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
