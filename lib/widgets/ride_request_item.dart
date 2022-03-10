import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/cache_img_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RideRequestItem extends StatelessWidget {
  const RideRequestItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

          IntrinsicHeight(
            child: Column(
              children: const [
                ListTile(
                  leading: Text('16:00'),
                  title: Text('Karachi'),
                  trailing: Text('Rs. 470.00'),
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                ),
                ListTile(
                  leading: Text('16:00'),
                  title: Text('Hyderabad'),
                  trailing: Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
          ),

          // IntrinsicHeight(
          //   child: Row(
          //     children: const [
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
