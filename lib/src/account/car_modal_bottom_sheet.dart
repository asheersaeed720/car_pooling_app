import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:car_pooling_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

void addCarModalBottomSheet(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _licenseNoController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (builder) {
      return Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 14.0),
              Container(
                width: 62.0,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 4.0, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 20, left: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/car_pooling.jpg',
                      width: 60.0,
                    ),
                    const SizedBox(width: 14.0),
                    Text('Add Car', style: kTitleStyle),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _nameController,
                prefixIcon: Icons.person,
                hintText: 'Name',
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _licenseNoController,
                prefixIcon: Icons.numbers,
                hintText: 'license No',
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _modelController,
                prefixIcon: Icons.numbers,
                hintText: 'Model',
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _colorController,
                prefixIcon: Icons.color_lens,
                hintText: 'Color',
              ),
              const SizedBox(height: 10.0),
              CustomAsyncBtn(
                btntxt: 'Add',
                onPress: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
