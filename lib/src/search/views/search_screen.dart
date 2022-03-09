import 'package:car_pooling_app/src/search/search_controller.dart';
import 'package:car_pooling_app/src/search/search_history.dart';
import 'package:car_pooling_app/src/search/views/search_location_screen.dart';
import 'package:car_pooling_app/src/search/views/search_result_screen.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/utils/display_toast_message.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search';

  SearchScreen({Key? key}) : super(key: key);

  final _searchController = Get.put(SearchController());

  final List<SearchHistory> _searchHistoryList = [
    SearchHistory(
      leavingPlace: 'Karachi',
      goingToPlace: 'Hydarabad',
      date: '${DateTime.now()}',
      passengers: '2',
    ),
    SearchHistory(
      leavingPlace: 'Lahore',
      goingToPlace: 'Hydarabad',
      date: '${DateTime.now()}',
      passengers: '1',
    ),
    SearchHistory(
      leavingPlace: 'Karachi',
      goingToPlace: 'Islamabad',
      date: '${DateTime.now()}',
      passengers: '2',
    ),
    SearchHistory(
      leavingPlace: 'Karachi',
      goingToPlace: 'Islamabad',
      date: '${DateTime.now()}',
      passengers: '2',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
              itemBuilder: (context, i) => _buildRecentSearchHistoryView(_searchHistoryList[i]),
              separatorBuilder: (context, i) => const Divider(),
              itemCount: _searchHistoryList.length,
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
              InkWell(
                onTap: () => Get.toNamed(SearchLocationScreen.routeName),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12, left: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Wrap(
                    spacing: 10.0,
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade600,
                      ),
                      Text(
                        _searchController.pickUpCityName.text.isEmpty
                            ? 'Leaving from'
                            : _searchController.pickUpCityName.text,
                        style: TextStyle(
                            color: _searchController.pickUpCityName.text.isEmpty
                                ? Colors.grey.shade700
                                : Colors.black87,
                            fontSize: 16.0),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              InkWell(
                onTap: () => Get.toNamed(SearchLocationScreen.routeName),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12, left: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Wrap(
                    spacing: 10.0,
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade600,
                      ),
                      Text(
                        _searchController.dropOffCityName.text.isEmpty
                            ? 'Going to'
                            : _searchController.dropOffCityName.text,
                        style: TextStyle(
                            color: _searchController.dropOffCityName.text.isEmpty
                                ? Colors.grey.shade700
                                : Colors.black87,
                            fontSize: 16.0),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              DateTimeField(
                format: DateFormat.yMMMEd(),
                decoration: const InputDecoration(hintText: 'Date'),
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
                  if (_searchController.pickUpCityId.text.isNotEmpty) {
                    Get.toNamed(
                      SearchResultScreen.routeName,
                      arguments: {
                        'pick_city_id': _searchController.pickUpCityId.text,
                        'dropoff_city_id': _searchController.dropOffCityId.text
                      },
                    );
                  } else {
                    displayToastMessage('Select City');
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearchHistoryView(SearchHistory searchItem) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          leading: const Icon(Icons.timelapse_rounded),
          title: Wrap(
            spacing: 10.0,
            children: [
              Text(searchItem.leavingPlace),
              Icon(
                Icons.arrow_forward,
                color: Colors.grey.shade600,
                size: 20.0,
              ),
              Text(searchItem.leavingPlace),
            ],
          ),
          subtitle: Text('${searchItem.date} ${searchItem.passengers}'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ],
    );
  }
}
