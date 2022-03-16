import 'dart:developer';

import 'package:car_pooling_app/src/place_picker/google_place_picker_screen.dart';
import 'package:car_pooling_app/src/search/search_controller.dart';
import 'package:car_pooling_app/src/search/views/search_result_screen.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:car_pooling_app/widgets/custom_text_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search';

  SearchScreen({Key? key}) : super(key: key);

  final _searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    log('pickUpAddress ${_searchController.pickUpAddress.text}');
    return GetBuilder<SearchController>(
      builder: (_) => ListView(
        children: [
          _buildSearchContainerView(context),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Recent Search', style: kTitleStyle),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.8,
            child: ListView.separated(
              itemBuilder: (context, i) => _buildRecentSearchHistoryView(),
              separatorBuilder: (context, i) => const Divider(),
              itemCount: 5,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchContainerView(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2.8,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/car_pooling.jpg"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.8,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.7),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.8,
          margin: const EdgeInsets.only(top: 98.0, left: 20.0, right: 20.0),
          padding: const EdgeInsets.only(top: 18.0, left: 20.0, right: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              // InkWell(
              //   onTap: () => Get.toNamed(GooglePlacePickerScreen.routeName),
              //   child: Container(
              //     width: double.infinity,
              //     padding: const EdgeInsets.only(top: 12.0, bottom: 12, left: 16.0),
              //     decoration: BoxDecoration(
              //       color: Colors.grey.shade200,
              //       borderRadius: BorderRadius.circular(6.0),
              //     ),
              //     child: Wrap(
              //       spacing: 10.0,
              //       children: [
              //         Icon(
              //           Icons.circle_outlined,
              //           color: Colors.grey.shade600,
              //         ),
              //         Text(
              //           _searchController.pickUpCityName.text.isEmpty
              //               ? 'Leaving from'
              //               : _searchController.pickUpCityName.text,
              //           style: TextStyle(
              //               color: _searchController.pickUpCityName.text.isEmpty
              //                   ? Colors.grey.shade700
              //                   : Colors.black87,
              //               fontSize: 16.0),
              //           textAlign: TextAlign.left,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              CustomTextField(
                controller: _searchController.pickUpAddress,
                prefixIcon: Icons.circle_outlined,
                hintText: 'Leaving from',
                onTap: () => Get.to(
                  () => const GooglePlacePickerScreen(),
                ),
              ),
              const SizedBox(height: 8.0),
              CustomTextField(
                controller: _searchController.dropOffAddress,
                prefixIcon: Icons.circle_outlined,
                hintText: 'Going to',
                onTap: () => Get.to(
                  () => const GooglePlacePickerScreen(isSelectdropOffAddress: true),
                ),
              ),
              const SizedBox(height: 8.0),
              DateTimeField(
                format: DateFormat.yMMMEd(),
                decoration: const InputDecoration(
                  hintText: 'Date',
                  prefixIcon: Icon(Icons.date_range),
                ),
                onShowPicker: (context, currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.convert(time);
                },
              ),
              const SizedBox(height: 8.0),
              CustomAsyncBtn(
                btntxt: 'Search',
                onPress: () {
                  // if (_searchController.pickUpAddress.text.isNotEmpty) {
                  // } else {
                  //   displayToastMessage('Select City');
                  // }
                  Get.toNamed(SearchResultScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearchHistoryView() {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          leading: const Icon(Icons.timelapse_rounded),
          title: Wrap(
            spacing: 10.0,
            children: [
              Text('Karachi'),
              Icon(
                Icons.arrow_forward,
                color: Colors.grey.shade600,
                size: 20.0,
              ),
              Text('Islamabad'),
            ],
          ),
          subtitle: Text('26 Mar 2022 3'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ],
    );
  }
}
