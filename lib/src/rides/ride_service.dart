import 'package:car_pooling_app/utils/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RideService extends GetConnect {
  Future<Response> addRide({
    required String pickUpAddress,
    required String pickUpDate,
    required String pickUpTime,
    required String pickUpLat,
    required String pickUpLong,
    required String dropOffAddress,
    required String dropOffDate,
    required String dropOffTime,
    required String dropOffLat,
    required String dropOffLong,
    required String price,
    required String passenger,
  }) async {
    var data = FormData({
      'pickup': pickUpAddress,
      'pickup_date': pickUpDate,
      'pickup_time': pickUpTime,
      'pickup_lat': pickUpLat,
      'pickup_long': pickUpLong,
      'drop': dropOffAddress,
      'drop_date': dropOffDate,
      'drop_time': dropOffTime,
      'drop_lat': dropOffLat,
      'drop_long': dropOffLong,
      'price': price,
      'passenger': passenger,
      'instruction': '',
    });

    return post(
      '$apiURL/Trips/address',
      data,
      contentType: 'form-data',
      headers: {'x-api-key': GetStorage().read('user')['key']},
    );
  }
}
