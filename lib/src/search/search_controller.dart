import 'dart:developer';
import 'dart:io';

import 'package:car_pooling_app/src/search/models/city.dart';
import 'package:car_pooling_app/src/search/models/user_ride_request.dart';
import 'package:car_pooling_app/src/search/search_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final _searchService = Get.put(SearchService());

  TextEditingController pickUpCityId = TextEditingController(text: '');
  TextEditingController dropOffCityId = TextEditingController(text: '');
  TextEditingController pickUpCityName = TextEditingController(text: '');
  TextEditingController dropOffCityName = TextEditingController(text: '');

  List<CityModel> citiesList = [];

  @override
  void onInit() {
    super.onInit();
    getRequests();
  }

  Future<List<UserRideRequest>> getRequests() async {
    try {
      var response = await _searchService.getRequests();
      log('${response.body}');
      if (response.statusCode == 200) {
        var responseJson = response.body;
        return (responseJson as List).map((i) => UserRideRequest.fromJson(i)).toList();
      } else {
        throw ('Failed to load Requests');
      }
    } on SocketException {
      throw ('No Internet connection');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CityModel>> getCities() async {
    citiesList = [];
    if (citiesList.isNotEmpty) return citiesList;
    var response = await _searchService.getCities();
    if (response.statusCode == 200) {
      response.body.forEach((res) => citiesList.add(CityModel.fromJson(res)));
      log('${response.body}');
    }
    return citiesList;
  }

  List<CityModel> getCitySuggestions(String query) {
    List<CityModel> matches = <CityModel>[];
    matches.addAll(citiesList);

    matches.retainWhere((s) => s.name.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
