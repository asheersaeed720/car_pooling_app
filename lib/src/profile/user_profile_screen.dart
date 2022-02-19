import 'package:car_pooling_app/src/auth/auth_controller.dart';
import 'package:car_pooling_app/widgets/cache_img_widget.dart';
import 'package:car_pooling_app/widgets/custom_async_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = '/user-profile';

  final bool isFromAllAppScreen;

  UserProfileScreen({Key? key, this.isFromAllAppScreen = false}) : super(key: key);

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GetBuilder<AuthController>(
          builder: (_) => Column(
            children: [
              Container(
                height: 275.0,
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 42),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: const CacheImgWidget(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                        width: 102.0,
                        height: 102.0,
                        borderRadius: 50.0,
                        isProfilePic: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '${_authController.currentUserData['name']}',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 27),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Theme style'),
                        StatusWidget(),
                      ],
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      initialValue: _authController.currentUserData['name'],
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      initialValue: _authController.currentUserData['email'],
                    ),
                    const SizedBox(height: 18),
                    CustomAsyncBtn(
                      btntxt: 'Logout',
                      onPress: () {
                        _authController.logoutUser();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // themeProvider.toggleTheme();
      },
      child: Container(
        width: 74,
        height: 29,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFFC6A57),
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(
              'Dark',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 12.0,
                  ),
            )),
            const Padding(
              padding: EdgeInsets.all(1.0),
              child: CircleAvatar(
                radius: 13,
                backgroundColor: Color(0xFFFFFFFF),
              ),
            )
          ],
        ),
      ),
    );
  }
}
