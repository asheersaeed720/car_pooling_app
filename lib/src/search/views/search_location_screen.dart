

// class SearchLocationScreen extends StatefulWidget {
//   static const String routeName = '/search-location';

//   const SearchLocationScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchLocationScreen> createState() => _SearchLocationScreenState();
// }

// class _SearchLocationScreenState extends State<SearchLocationScreen> {
//   final _searchController = Get.put(SearchController());

//   @override
//   void initState() {
//     _searchController.getCities();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<SearchController>(
//         builder: (_) => Stack(
//           clipBehavior: Clip.none,
//           children: [
//             ListView(
//               padding: const EdgeInsets.only(top: 46.0, right: 12.0, left: 12.0),
//               children: [
//                 _buildPickUpCitySearchView(),
//                 const SizedBox(height: 10.0),
//                 _buildDropOffCitySearchView(),
//               ],
//             ),
//             const Positioned(child: GooglePlacePickerScreen())
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPickUpCitySearchView() {
//     return TypeAheadField(
//       textFieldConfiguration: TextFieldConfiguration(
//         controller: _searchController.pickUpCityName,
//         autofocus: true,
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 22.0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: const BorderSide(style: BorderStyle.none, width: 0),
//           ),
//           isDense: true,
//           hintText: 'Leaving city',
//           prefixIcon: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.0),
//             child: Icon(Icons.circle_outlined, size: 22.0),
//           ),
//           suffixIcon: _searchController.pickUpCityName.text.isEmpty
//               ? const SizedBox.shrink()
//               : IconButton(
//                   icon: Icon(
//                     Icons.cancel,
//                     color: Theme.of(context).hintColor.withOpacity(0.3),
//                     size: 22.0,
//                   ),
//                   onPressed: () {
//                     _searchController.pickUpCityId.clear();
//                     _searchController.pickUpCityName.clear();
//                     _searchController.update();
//                   },
//                 ),
//         ),
//       ),
//       suggestionsCallback: (pattern) async {
//         return _searchController.getCitySuggestions(pattern);
//       },
//       itemBuilder: (context, CityModel city) {
//         return ListTile(
//           title: Text(city.name),
//         );
//       },
//       onSuggestionSelected: (CityModel suggestion) {
//         _searchController.pickUpCityId.text = suggestion.id;
//         _searchController.pickUpCityName.text = suggestion.name;
//         _searchController.update();
//       },
//     );
//   }

//   Widget _buildDropOffCitySearchView() {
//     return TypeAheadField(
//       textFieldConfiguration: TextFieldConfiguration(
//         controller: _searchController.dropOffCityName,
//         autofocus: true,
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 22.0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: const BorderSide(style: BorderStyle.none, width: 0),
//           ),
//           isDense: true,
//           hintText: 'Drop off city',
//           prefixIcon: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.0),
//             child: Icon(Icons.circle_outlined, size: 22.0),
//           ),
//           suffixIcon: _searchController.dropOffCityName.text.isEmpty
//               ? const SizedBox.shrink()
//               : IconButton(
//                   icon: Icon(
//                     Icons.cancel,
//                     color: Theme.of(context).hintColor.withOpacity(0.3),
//                     size: 22.0,
//                   ),
//                   onPressed: () {
//                     _searchController.dropOffCityId.clear();
//                     _searchController.dropOffCityName.clear();
//                     _searchController.update();
//                   },
//                 ),
//         ),
//       ),
//       suggestionsCallback: (pattern) async {
//         return _searchController.getCitySuggestions(pattern);
//       },
//       itemBuilder: (context, CityModel city) {
//         return ListTile(
//           title: Text(city.name),
//         );
//       },
//       onSuggestionSelected: (CityModel suggestion) {
//         if (_searchController.pickUpCityId.text.isNotEmpty) {
//           if (suggestion.id != _searchController.pickUpCityId.text) {
//             _searchController.dropOffCityId.text = suggestion.id;
//             _searchController.dropOffCityName.text = suggestion.name;
//             Get.back();
//           } else {
//             displayToastMessage("You can't select same city");
//           }
//         } else {
//           displayToastMessage("Select pick up city first");
//         }
//         _searchController.update();
//       },
//     );
//   }
// }
