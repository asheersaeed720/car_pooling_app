

// class TabScreen extends StatefulWidget {
//   static const String routeName = '/tab';

//   const TabScreen({Key? key}) : super(key: key);

//   @override
//   _TabScreenState createState() => _TabScreenState();
// }

// class _TabScreenState extends State<TabScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = <Widget>[
//     const HomeScreen(),
//     const HomeScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       appBar: customAppBar(context, 'Property App'),
//       body: _pages.elementAt(_selectedIndex),
//       bottomNavigationBar: CurvedNavigationBar(
//         buttonBackgroundColor: AppTheme.primary,
//         backgroundColor: Colors.white,
//         color: AppTheme.primary,
//         animationDuration: const Duration(milliseconds: 400),
//         index: _selectedIndex,
//         items: const <Widget>[
//           Icon(Icons.home, size: 30, color: Colors.white),
//           Icon(Icons.business, size: 30, color: Colors.white),
//         ],
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
