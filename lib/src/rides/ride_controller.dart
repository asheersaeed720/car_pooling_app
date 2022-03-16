import 'dart:developer';

import 'package:car_pooling_app/src/network_manager.dart';
import 'package:car_pooling_app/src/rides/ride_service.dart';
import 'package:car_pooling_app/utils/custom_snack_bar.dart';
import 'package:car_pooling_app/utils/display_toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideController extends NetworkManager {
  final _rideService = Get.put(RideService());

  final TextEditingController pickAddressController = TextEditingController();
  final TextEditingController pickUpDateController = TextEditingController();
  final TextEditingController pickUpTimeController = TextEditingController();
  final TextEditingController pickLatController = TextEditingController();
  final TextEditingController pickLongController = TextEditingController();
  final TextEditingController dropOffAddressController = TextEditingController();
  final TextEditingController dropOffDateController = TextEditingController();
  final TextEditingController dropOffTimeController = TextEditingController();
  final TextEditingController dropOffLatController = TextEditingController();
  final TextEditingController dropOffLongController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController passengerController = TextEditingController();

  Future<void> addRide() async {
    if (connectionType != 0) {
      try {
        var response = await _rideService.addRide(
          pickUpAddress: pickAddressController.text,
          pickUpDate: pickUpDateController.text,
          pickUpTime: pickUpTimeController.text,
          pickUpLat: pickLatController.text,
          pickUpLong: pickLongController.text,
          dropOffAddress: dropOffAddressController.text,
          dropOffDate: dropOffDateController.text,
          dropOffTime: dropOffTimeController.text,
          dropOffLat: dropOffLatController.text,
          dropOffLong: dropOffLongController.text,
          price: priceController.text,
          passenger: passengerController.text,
        );
        if (response.statusCode == 200) {
          displayToastMessage('Ride Added');
        } else {
          displayToastMessage('${response.body['message']}');
        }
        log('rideRes ${response.body}, type:${response.body.runtimeType}');
      } catch (e) {
        displayToastMessage(e);
        rethrow;
      }
    } else {
      customSnackBar('Network error', 'Please try again later');
    }
  }
}
