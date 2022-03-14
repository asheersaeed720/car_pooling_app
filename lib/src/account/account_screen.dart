import 'package:car_pooling_app/src/account/car_modal_bottom_sheet.dart';
import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:car_pooling_app/utils/constants.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GetBuilder<AuthController>(
          builder: (_) {
            return ListView(
              children: [
                _buildLessProfileInfoView(context),
                const Divider(thickness: 10.0, height: 20.0),
                _buildSupportView(context),
                const Divider(thickness: 10.0, height: 20.0),
                _buildPreferenceView(context),
                const Divider(thickness: 10.0, height: 20.0),
                _buildMyAppView(context),
                const SizedBox(height: 8.0),
                // !_authController.isLoggedIn
                //     ? const SizedBox.shrink()
                //     : CustomButton(
                //         btnTxt: 'Logout',
                //         onPressed: () {
                //           customAlertDialog(
                //             context,
                //             'Logout',
                //             'Are you sure you want to logout?',
                //             _authController.disableWhileLoad
                //                 ? null
                //                 : () async {
                //                     await _authController.signOutUser();
                //                   },
                //           );
                //         },
                //       ),
                const SizedBox(height: 8.0),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLessProfileInfoView(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: Image.asset(
          'assets/images/no_img_available.jpg',
          width: 42.0,
          height: 42.0,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        'Test',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: const Text('test@gmail.com'),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 24.0,
      ),
    );
  }

  Widget _buildSupportView(context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Support',
            style: kTitleStyle,
          ),
        ),
        // const SizedBox(height: 10.0),
        // ListTile(
        //   title: Text(
        //     'Help Center',
        //     style: TextStyle(
        //       fontFamily: AppTheme.fontName,
        //       fontWeight: FontWeight.w600,
        //       fontSize: 16.0,
        //       color: Colors.black54,
        //     ),
        //   ),
        //   trailing: Icon(Icons.arrow_forward_ios_rounded),
        // ),
        // const Divider(thickness: 1.0, height: 20.0),
        const ListTile(
          title: Text(
            'Feedback',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
        ),
      ],
    );
  }

  Widget _buildPreferenceView(context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Preferences',
            style: kTitleStyle,
          ),
        ),
        const SizedBox(height: 10.0),
        ListTile(
          title: const Text(
            'Language',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
          trailing: Wrap(
            children: const [
              Text(
                'English (UK)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 1.0, height: 20.0),
            ListTile(
              title: const Text(
                'Notification',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
                activeTrackColor: Colors.lightBlue,
                activeColor: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMyAppView(context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Car Pooling App',
            style: kTitleStyle,
          ),
        ),
        const SizedBox(height: 10.0),
        ListTile(
          onTap: () async {
            addCarModalBottomSheet(context);
          },
          title: const Text(
            'Add Car',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        const Divider(thickness: 1.0, height: 20.0),
        ListTile(
          onTap: () async {
            // await launch('https://travelbegin.restncode.com/privacy-policy.html');
          },
          title: const Text(
            'Privacy Policy',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        const Divider(thickness: 1.0, height: 20.0),
        ListTile(
          onTap: () async {
            // await launch('https://travelbegin.restncode.com/terms-and-condition.html');
          },
          title: const Text(
            'Terms of use',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        const Divider(thickness: 1.0, height: 20.0),
        CustomAsyncBtn(
          btntxt: 'Logout',
          onPress: () {
            _authController.logoutUser();
          },
        )
      ],
    );
  }
}
