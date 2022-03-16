import 'package:car_pooling_app/src/account/account_screen.dart';
import 'package:car_pooling_app/src/rides/views/add_ride_screen.dart';
import 'package:car_pooling_app/src/rides/views/user_ride_screen.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat/views/chat_screen.dart';
import 'search/views/search_screen.dart';

class TabScreen extends StatelessWidget {
  static const String routeName = '/tab';

  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      SearchScreen(),
      const UserRidesScreen(),
      AddRideScreen(),
      const ChatScreen(),
      AccountScreen(),
    ];

    return DefaultTabController(
      length: 5,
      child: GetBuilder<TabController>(
        init: TabController(),
        builder: (tabController) => Scaffold(
          body: _widgetOptions.elementAt(tabController.selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.track_changes),
                label: 'Your Rides',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Publish',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              ),
            ],
            currentIndex: tabController.selectedIndex,
            selectedItemColor: primaryColor,
            onTap: tabController.onItemTapped,
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 2.5),
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: FloatingActionButton(
              elevation: 4.0,
              disabledElevation: 0,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: primaryColor,
                size: 28.0,
              ),
              onPressed: () {
                tabController.onItemTapped(2);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TabController extends GetxController {
  int selectedIndex = 0;

  onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
