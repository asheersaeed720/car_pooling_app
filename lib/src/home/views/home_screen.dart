

// class HomeScreen extends StatefulWidget {
//   static const String routeName = '/';

//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// List<Map> navigationBarItems = [
//   {'icon': Icons.local_hospital, 'index': 0},
//   {'icon': Icons.calendar_today, 'index': 1},
// ];

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   void goToSchedule() {
//     setState(() {
//       _selectedIndex = 1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> screens = [
//       HomeTab(
//         onPressedScheduleCard: goToSchedule,
//       ),
//       const ScheduleTab(),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         toolbarHeight: 0,
//       ),
//       body: SafeArea(
//         child: screens[_selectedIndex],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedFontSize: 0,
//         selectedItemColor: primaryColor,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: [
//           for (var navigationBarItem in navigationBarItems)
//             BottomNavigationBarItem(
//               icon: Container(
//                 height: 55,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: _selectedIndex == navigationBarItem['index']
//                         ? const BorderSide(width: 5)
//                         : BorderSide.none,
//                   ),
//                 ),
//                 child: Icon(
//                   navigationBarItem['icon'],
//                 ),
//               ),
//               label: '',
//             ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: (value) => setState(() {
//           _selectedIndex = value;
//         }),
//       ),
//     );
//   }
// }
