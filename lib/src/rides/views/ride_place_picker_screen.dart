import 'package:car_pooling_app/src/rides/ride_controller.dart';
import 'package:car_pooling_app/utils/api.dart';
import 'package:car_pooling_app/utils/display_toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

class RidePlacePickerScreen extends StatelessWidget {
  static const String routeName = '/ride-place-picker';

  const RidePlacePickerScreen({this.isSelectdropOffAddress = false, Key? key}) : super(key: key);

  final bool isSelectdropOffAddress;

  static const kInitialPosition = LatLng(24.9008, 67.1681);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      init: RideController(),
      builder: (rideController) => PlacePicker(
        apiKey: googleApiKey,
        initialPosition: kInitialPosition,
        selectInitialPosition: true,
        onPlacePicked: (result) {
          if (isSelectdropOffAddress) {
            if (rideController.pickAddressController.text == result.formattedAddress) {
              displayToastMessage('You can not select same place');
            } else {
              rideController.dropOffAddressController.text = result.formattedAddress ?? '';
              rideController.dropOffLatController.text = '${result.geometry?.location.lat}';
              rideController.dropOffLongController.text = '${result.geometry?.location.lng}';
            }
          } else {
            rideController.pickAddressController.text = result.formattedAddress ?? '';
            rideController.pickLatController.text = '${result.geometry?.location.lat}';
            rideController.pickLongController.text = '${result.geometry?.location.lng}';
          }
          rideController.update();
          Get.back();
        },
      ),
    );
  }
}
