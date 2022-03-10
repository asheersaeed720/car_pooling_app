import 'package:car_pooling_app/src/rides/models/ride_model.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/ride_request_item.dart';
import 'package:flutter/material.dart';

class UserRideScreen extends StatefulWidget {
  const UserRideScreen({Key? key}) : super(key: key);

  @override
  State<UserRideScreen> createState() => _UserRideScreenState();
}

enum UserStatusFilter { ongoing, complete, cancel }

List<RideRequest> _userRideDataList = [];

class _UserRideScreenState extends State<UserRideScreen> {
  UserStatusFilter status = UserStatusFilter.ongoing;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    // List<Map> filteredSchedules = schedules.where((var schedule) {
    //   return schedule['status'] == status;
    // }).toList();

    List<RideRequest> filteredRides =
        _userRideDataList.where((var ride) => ride.status == status).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Rides'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (UserStatusFilter filterStatus in UserStatusFilter.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == UserStatusFilter.ongoing) {
                                  status = UserStatusFilter.ongoing;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus == UserStatusFilter.complete) {
                                  status = UserStatusFilter.complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus == UserStatusFilter.cancel) {
                                  status = UserStatusFilter.cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name.capitalize(),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRides.length,
                itemBuilder: (context, index) {
                  var _ride = filteredRides[index];
                  bool isLastElement = filteredRides.length + 1 == index;
                  return const RideRequestItem();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  const DateTimeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.calendar_today,
                color: primaryColor,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Mon, July 29',
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Icon(
                Icons.access_alarm,
                color: primaryColor,
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '11:00 ~ 12:10',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
