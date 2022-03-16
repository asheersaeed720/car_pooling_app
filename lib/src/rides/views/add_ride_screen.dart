import 'package:car_pooling_app/src/auth/header_widget.dart';
import 'package:car_pooling_app/src/rides/ride_controller.dart';
import 'package:car_pooling_app/src/rides/views/ride_place_picker_screen.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:car_pooling_app/widgets/custom_text_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddRideScreen extends StatelessWidget {
  AddRideScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const HeaderWidget(),
        GetBuilder<RideController>(
          init: RideController(),
          builder: (rideController) => Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Publish Your Ride',
                    style: kTitleStyle,
                  ),
                  const SizedBox(height: 18.0),
                  CustomTextField(
                    controller: rideController.pickAddressController,
                    hintText: 'Pick up',
                    prefixIcon: Icons.circle_outlined,
                    onTap: () => Get.to(
                      () => const RidePlacePickerScreen(),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    hintText: 'Drop off',
                    controller: rideController.dropOffAddressController,
                    prefixIcon: Icons.circle_outlined,
                    onTap: () => Get.to(
                      () => const RidePlacePickerScreen(isSelectdropOffAddress: true),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    hintText: 'Set Price',
                    controller: rideController.priceController,
                    inputType: TextInputType.number,
                    prefixIcon: Icons.price_check_sharp,
                  ),
                  const SizedBox(height: 10.0),
                  DateTimeField(
                    format: DateFormat.yMMMEd(),
                    decoration: const InputDecoration(
                      hintText: 'Pick-up Date & Time',
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Required Field';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      String date = DateFormat('yyyy-MM-dd').format(value ?? DateTime.now());
                      String time = DateFormat.Hms().format(value ?? DateTime.now());
                      rideController.pickUpDateController.text = date;
                      rideController.pickUpTimeController.text = time;
                    },
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),
                  DateTimeField(
                    format: DateFormat.yMMMEd(),
                    decoration: const InputDecoration(
                      hintText: 'Drop-off Date & Time',
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Required Field';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      String date = DateFormat('yyyy-MM-dd').format(value ?? DateTime.now());
                      String time = DateFormat.Hms().format(value ?? DateTime.now());
                      rideController.dropOffDateController.text = date;
                      rideController.dropOffTimeController.text = time;
                    },
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: rideController.passengerController,
                    prefixIcon: Icons.person_add,
                    inputType: TextInputType.number,
                    hintText: 'Passengers',
                  ),
                  const SizedBox(height: 10.0),
                  CustomAsyncBtn(
                    btntxt: 'Publish',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        Get.put(RideController()).addRide();
                      }
                    },
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
