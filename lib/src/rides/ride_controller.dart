import 'dart:developer';

import 'package:car_pooling_app/src/network_manager.dart';
import 'package:car_pooling_app/src/rides/ride_service.dart';
import 'package:car_pooling_app/utils/custom_snack_bar.dart';
import 'package:car_pooling_app/utils/display_toast_message.dart';
import 'package:get/get.dart';

class RideController extends NetworkManager {
  final _rideService = Get.put(RideService());

  Future<void> addRide() async {
    if (connectionType != 0) {
      try {
        var response = await _rideService.addRide();
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
