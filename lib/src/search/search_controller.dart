import 'dart:developer';
import 'dart:io';

import 'package:car_pooling_app/src/rides/models/ride_model.dart';
import 'package:car_pooling_app/src/search/models/city_model.dart';
import 'package:car_pooling_app/src/search/search_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final _searchService = Get.put(SearchService());

  TextEditingController pickUpAddress = TextEditingController(text: '');
  TextEditingController pickUpLat = TextEditingController(text: '');
  TextEditingController pickUpLong = TextEditingController(text: '');
  TextEditingController dropOffAddress = TextEditingController(text: '');
  TextEditingController dropOffLat = TextEditingController(text: '');
  TextEditingController dropOffLong = TextEditingController(text: '');

  List<CityModel> citiesList = [];

  @override
  void onInit() {
    super.onInit();
    getRequests();
  }

  Future<List<RideRequest>> getRequests() async {
    try {
      var response = await _searchService.getRequests();
      log('${response.body}');
      if (response.statusCode == 200) {
        var responseJson = response.body;
        return (responseJson as List).map((i) => RideRequest.fromJson(i)).toList();
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
