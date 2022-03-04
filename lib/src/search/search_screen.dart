import 'package:car_pooling_app/src/search/search_history.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search';

  SearchScreen({Key? key}) : super(key: key);

  final List<SearchHistory> _searchHistoryList = [
    SearchHistory(
      leavingPlace: 'Karachi',
      goingToPlace: 'Hydarabad',
      date: '${DateTime.now()}',
      passengers: '2',
    ),
    SearchHistory(
      leavingPlace: 'Lahore',
      goingToPlace: 'Hydarabad',
      date: '${DateTime.now()}',
      passengers: '1',
    ),
    SearchHistory(
      leavingPlace: 'Karachi',
      goingToPlace: 'Islamabad',
      date: '${DateTime.now()}',
      passengers: '2',
    ),
    SearchHistory(
      leavingPlace: 'Karachi',
      goingToPlace: 'Islamabad',
      date: '${DateTime.now()}',
      passengers: '2',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildSearchContainerView(context),
        const SizedBox(height: 10.0),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.8,
          child: ListView.separated(
            itemBuilder: (context, i) => _buildRecentSearchHistoryView(_searchHistoryList[i]),
            separatorBuilder: (context, i) => const Divider(),
            itemCount: _searchHistoryList.length,
          ),
        )
      ],
    );
  }

  Widget _buildSearchContainerView(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2.8,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/car_pooling.jpg"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.8,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.7),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.8,
          margin: const EdgeInsets.only(top: 98.0, left: 20.0, right: 20.0),
          padding: const EdgeInsets.only(top: 18.0, left: 20.0, right: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 12.0, bottom: 12, left: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Wrap(
                  spacing: 10.0,
                  children: [
                    Icon(
                      Icons.circle_outlined,
                      color: Colors.grey.shade600,
                    ),
                    Text(
                      'Leaving from',
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 16.0),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 12.0, bottom: 12, left: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Wrap(
                  spacing: 10.0,
                  children: [
                    Icon(
                      Icons.circle_outlined,
                      color: Colors.grey.shade600,
                    ),
                    Text(
                      'Going to',
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 16.0),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6.0),
              DateTimeField(
                format: DateFormat.yMMMEd(),
                decoration: const InputDecoration(hintText: 'Date'),
                onShowPicker: (context, currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.convert(time);
                },
              ),
              const SizedBox(height: 6.0),
              CustomAsyncBtn(
                btntxt: 'Search',
                onPress: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearchHistoryView(SearchHistory searchItem) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          leading: const Icon(Icons.timelapse_rounded),
          title: Wrap(
            spacing: 10.0,
            children: [
              Text(searchItem.leavingPlace),
              Icon(
                Icons.arrow_forward,
                color: Colors.grey.shade600,
                size: 20.0,
              ),
              Text(searchItem.leavingPlace),
            ],
          ),
          subtitle: Text('${searchItem.date} ${searchItem.passengers}'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ],
    );
  }
}
