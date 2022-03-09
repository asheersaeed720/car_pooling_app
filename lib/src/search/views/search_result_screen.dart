import 'package:car_pooling_app/src/search/models/user_ride_request.dart';
import 'package:car_pooling_app/src/search/search_controller.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/cache_img_widget.dart';
import 'package:car_pooling_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class SearchResultScreen extends StatelessWidget {
  static const String routeName = '/search-result';

  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: const Color(0xFFEEEDEF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEDEF),
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('User Requests'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: Icon(
              Icons.filter_alt_outlined,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0, left: 12.0, right: 12.0),
        child: GetBuilder<SearchController>(
          init: SearchController(),
          builder: (searchController) {
            return FutureBuilder<List<UserRideRequest>>(
              future: searchController.getRequests(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<UserRideRequest> userRideRequestList = snapshot.data ?? [];
                  // return Text(userRideRequestList[0].carId);
                  return ListView.separated(
                    itemBuilder: (context, i) {
                      return _buildUserRideRequestView(userRideRequestList[i]);
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

  Widget _buildUserRideRequestView(UserRideRequest rideRequest) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: const CacheImgWidget('', isProfilePic: true),
            title: const Text('Asghar Jameel'),
            subtitle: Wrap(
              spacing: 8.0,
              children: [
                RatingBar.builder(
                  itemSize: 18.0,
                  initialRating: 4.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, i) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Text('(8)'),
              ],
            ),
            trailing: const Icon(Icons.chat, color: primaryColor),
          ),
          const ListTile(
            leading: Text('16:00'),
            title: Text('Karachi'),
            trailing: Text('Rs. 470.00'),
          ),

          const ListTile(
            leading: Text('16:00'),
            title: Text('Hyderabad'),
          ),
          // IntrinsicHeight(
          //   child: Row(
          //     children:const [
          //       Text('Hello'),
          //       VerticalDivider(
          //         color: Colors.black,
          //         thickness: 2,
          //       ),
          //       Text('World'),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
