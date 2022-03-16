import 'package:car_pooling_app/src/search/search_controller.dart';
import 'package:car_pooling_app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

class GooglePlacePickerScreen extends StatelessWidget {
  static const String routeName = '/google-place-picker';

  const GooglePlacePickerScreen({this.isSelectdropOffAddress = false, Key? key}) : super(key: key);

  final bool isSelectdropOffAddress;

  static const kInitialPosition = LatLng(24.9008, 67.1681);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      builder: (searchController) => PlacePicker(
        apiKey: googleApiKey,
        initialPosition: kInitialPosition,
        // useCurrentLocation: true,
        selectInitialPosition: true,
        //usePlaceDetailSearch: true,
        onPlacePicked: (result) {
          if (isSelectdropOffAddress) {
            searchController.dropOffAddress.text = result.formattedAddress ?? '';
          } else {
            searchController.pickUpAddress.text = result.formattedAddress ?? '';
          }
          searchController.update();
          Get.back();
        },
      ),
    );
  }
}
