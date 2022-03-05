import 'package:car_pooling_app/src/auth/header_widget.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:car_pooling_app/widgets/custom_text_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddRideScreen extends StatelessWidget {
  const AddRideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const HeaderWidget(),
        Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Publish Your Ride',
                style: kTitleStyle,
              ),
              const SizedBox(height: 18.0),
              const CustomTextField(
                hintText: 'Pick up',
                prefixIcon: Icons.circle_outlined,
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                onTap: () {
                  print('noob');
                },
                hintText: 'Drop off',
                prefixIcon: Icons.circle_outlined,
              ),
              const SizedBox(height: 10.0),
              const CustomTextField(
                hintText: 'Set Price',
                inputType: TextInputType.number,
                prefixIcon: Icons.price_check_sharp,
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
              const SizedBox(height: 10.0),
              const CustomTextField(
                prefixIcon: Icons.person_add,
                inputType: TextInputType.number,
                hintText: 'Passengers',
              ),
              const SizedBox(height: 10.0),
              CustomAsyncBtn(
                btntxt: 'Publish',
                onPress: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
