import 'package:car_pooling_app/src/ride/models/ride_model.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:flutter/material.dart';

class UserRiderScreen extends StatefulWidget {
  const UserRiderScreen({Key? key}) : super(key: key);

  @override
  State<UserRiderScreen> createState() => _UserRiderScreenState();
}

enum UserStatusFilter { ongoing, complete, cancel }

List<RideModel> _userRideDataList = [
  RideModel(
    pickUpTime: '16:40',
    dropOffTime: '19:10',
    pickUpCity: 'Karachi',
    dropOffCity: 'Islamabad',
    riderName: 'Hassan Jahangir',
    profilePic: 'assets/images/no_img_available.jpg',
    rating: 4.0,
    price: '700',
    availableSlots: '2',
    status: UserStatusFilter.ongoing,
  ),
  RideModel(
    pickUpTime: '23:00',
    dropOffTime: '19:10',
    pickUpCity: 'Hyderabad',
    dropOffCity: 'Lahore',
    riderName: 'Aslam Babu',
    profilePic: 'assets/images/no_img_available.jpg',
    rating: 3.0,
    price: '600',
    availableSlots: '2',
    status: UserStatusFilter.ongoing,
  ),
  RideModel(
    pickUpTime: '15:00',
    dropOffTime: '21:30',
    pickUpCity: 'Karachi',
    dropOffCity: 'Abbottabad',
    riderName: 'Jameel Khan',
    profilePic: 'assets/images/no_img_available.jpg',
    rating: 4.5,
    price: '1200',
    availableSlots: '1',
    status: UserStatusFilter.complete,
  ),
  RideModel(
    pickUpTime: '13:50',
    dropOffTime: '17:10',
    pickUpCity: 'Rawalpindi',
    dropOffCity: 'Islamabad',
    riderName: 'Zain Chugtai',
    profilePic: 'assets/images/person.jpeg',
    rating: 5.0,
    price: '500',
    availableSlots: '1',
    status: UserStatusFilter.cancel,
  ),
];

class _UserRiderScreenState extends State<UserRiderScreen> {
  UserStatusFilter status = UserStatusFilter.ongoing;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    // List<Map> filteredSchedules = schedules.where((var schedule) {
    //   return schedule['status'] == status;
    // }).toList();

    List<RideModel> filteredRides =
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
                  return Card(
                    margin: !isLastElement ? const EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(_ride.profilePic),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _ride.riderName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    '_schedule',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const DateTimeCard(),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  child: const Text('Reschedule'),
                                  onPressed: () => {},
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
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
