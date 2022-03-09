import 'package:car_pooling_app/utils/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchService extends GetConnect {
  Future<Response> getCities() async {
    return get('$apiURL/Cities/all', contentType: 'form-data');
  }

  Future<Response> getRequests() async {
    return get(
      '$apiURL/Trips/search',
      contentType: 'form-data',
      headers: {'x-api-key': GetStorage().read('user')['key']},
    );
  }
}
