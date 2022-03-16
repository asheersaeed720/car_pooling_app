import 'dart:developer';

import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/cache_img_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserRidesScreen extends StatelessWidget {
  const UserRidesScreen({Key? key}) : super(key: key);

  final TextStyle kRideTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    color: primaryColor,
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelColor: primaryColor,
            tabs: [
              Tab(text: 'Taken Rides'),
              Tab(text: 'Given Rides'),
            ],
          ),
          title: const Text('My Rides'),
        ),
        body: TabBarView(
          children: [
            const Text('Taken Rides'),
            ListView.separated(
              itemBuilder: (context, i) {
                return _buildGivenRidesView();
              },
              separatorBuilder: (context, _) => const SizedBox(height: 10.0),
              itemCount: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGivenRidesView() {
    return Container(
      margin: const EdgeInsets.all(18.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CacheImgWidget('', isProfilePic: true),
            title: Text(
              'Name',
              style: kRideTextStyle,
            ),
            subtitle: RatingBar.builder(
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
                log('$rating');
              },
            ),
            trailing: Text(
              'Rs.900.00',
              style: kRideTextStyle,
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '21:30',
                          style: kRideTextStyle,
                        ),
                        const SizedBox(height: 32.0),
                        Text(
                          '05:20',
                          style: kRideTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10.0),
                    const VerticalDivider(
                      color: primaryColor,
                      indent: 10.0,
                      endIndent: 10.0,
                      thickness: 1.5,
                    ),
                    const SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'North Karachi',
                          style: kRideTextStyle,
                        ),
                        const SizedBox(height: 32.0),
                        Text(
                          'New Landhi',
                          style: kRideTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
