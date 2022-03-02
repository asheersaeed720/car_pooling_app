import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/custom_text_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildHeaderView(context),
      ],
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/car_pooling.jpg"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3.0,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.7),
          ),
          child: Container(
            margin: const EdgeInsets.all(22.0),
            padding: const EdgeInsets.all(22.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Column(
              children: [
                const CustomTextField(
                  prefixIcon: Icons.circle_outlined,
                  hintText: 'Leaving from',
                ),
                const SizedBox(height: 10.0),
                const CustomTextField(
                  prefixIcon: Icons.circle_outlined,
                  hintText: 'Going to',
                ),
                const SizedBox(height: 10.0),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
