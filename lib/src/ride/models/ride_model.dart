import 'package:car_pooling_app/src/ride/views/user_ride_screen.dart';

class RideModel {
  final String pickUpTime;
  final String dropOffTime;
  final String pickUpCity;
  final String dropOffCity;
  final String riderName;
  final String profilePic;
  final double rating;
  final String price;
  final String availableSlots;
  final UserStatusFilter status;

  RideModel({
    required this.pickUpTime,
    required this.dropOffTime,
    required this.pickUpCity,
    required this.dropOffCity,
    required this.riderName,
    required this.profilePic,
    required this.rating,
    required this.price,
    required this.availableSlots,
    required this.status,
  });
}
