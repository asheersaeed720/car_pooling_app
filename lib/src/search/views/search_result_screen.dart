import 'package:car_pooling_app/src/rides/models/ride_model.dart';
import 'package:car_pooling_app/src/search/filter_modal_bottom.dart';
import 'package:car_pooling_app/src/search/search_controller.dart';
import 'package:car_pooling_app/widgets/loading_widget.dart';
import 'package:car_pooling_app/widgets/ride_request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultScreen extends StatelessWidget {
  static const String routeName = '/search-result';

  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? arg;
    if (arg != null) {
      arg = Get.arguments as Map<String, dynamic>;
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Requests'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: IconButton(
              onPressed: () => filterModalBottomSheet(context),
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0, left: 12.0, right: 12.0),
        child: GetBuilder<SearchController>(
          init: SearchController(),
          builder: (searchController) {
            return FutureBuilder<List<RideRequest>>(
              future: searchController.getRequests(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<RideRequest> userRideRequestList = snapshot.data ?? [];
                  return ListView.separated(
                    itemBuilder: (context, i) {
                      return const RideRequestItem();
                    },
                    separatorBuilder: (context, i) => const SizedBox(height: 10.0),
                    itemCount: userRideRequestList.length,
                  );
                }
                return const LoadingWidget();
              },
            );
          },
        ),
      ),
    );
  }
}
