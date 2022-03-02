import 'package:car_pooling_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat/views/chat_screen.dart';
import 'search/search_screen.dart';

class TabScreen extends StatelessWidget {
  static const String routeName = '/tab';

  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<Widget> _widgetOptions = <Widget>[
      SearchScreen(),
      Text('Index 2: School'),
      Text('Index 3: Settings'),
      ChatScreen(),
      Text('Index 3: Settings'),
    ];

    return DefaultTabController(
      length: 5,
      child: GetBuilder<TabController>(
        init: TabController(),
        builder: (tabController) => Scaffold(
          // appBar: AppBar(
          //   title: const Text('BottomNavigationBar Sample'),
          // ),
          body: Center(
            child: _widgetOptions.elementAt(tabController.selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Publish',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.track_changes),
                label: 'Your Rides',
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
