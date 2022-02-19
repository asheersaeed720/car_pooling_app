import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  const GoogleMapWidget({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _kGooglePlex;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 10,
    );
    _markers.add(
      Marker(
        markerId: MarkerId('${widget.latitude}${widget.longitude}'),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(
          widget.latitude,
          widget.longitude,
        ),
        infoWindow: const InfoWindow(title: "Location"),
      ),
    );
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
