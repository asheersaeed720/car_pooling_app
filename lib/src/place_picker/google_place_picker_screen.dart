import 'package:car_pooling_app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class GooglePlacePickerScreen extends StatelessWidget {
  static const String routeName = '/google-place-picker';

  const GooglePlacePickerScreen({Key? key}) : super(key: key);

  static const kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: googleApiKey,
      initialPosition: kInitialPosition,
      useCurrentLocation: true,
      selectInitialPosition: true,
      //usePlaceDetailSearch: true,
      onPlacePicked: (result) {
        // selectedPlace = result;
      },
    );
  }
}
