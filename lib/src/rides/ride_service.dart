import 'package:car_pooling_app/utils/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RideService extends GetConnect {
  Future<Response> addRide() async {
    var data = FormData({
      'car_id': '1',
      'from_city_id': '1',
      'from_lat': '24.8607',
      'from_long': '67.0011',
      'to_city_id': '2',
      'to_lat': '31.5204',
      'to_long': '74.3587',
      'capacity': '1',
      'rate': '3000',
      'pick_up_time': '12:00',
      'drop_off_time': '04:00',
    });

    return post(
      '$apiURL/Trips/create',
      data,
      contentType: 'form-data',
      headers: {'x-api-key': GetStorage().read('user')['key']},
    );
  }
}
