import 'package:car_pooling_app/src/auth/views/login_screen.dart';
import 'package:car_pooling_app/src/main_binding.dart';
import 'package:car_pooling_app/src/tab_screen.dart';
import 'package:car_pooling_app/utils/app_theme.dart';
import 'package:car_pooling_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'Car Pooling',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        // darkTheme: darkThemeData,
        initialBinding: MainBinding(),
        initialRoute:
            GetStorage().read('user') == null ? LogInScreen.routeName : TabScreen.routeName,
        // initialRoute: AuthScreen.routeName,
        getPages: routes,
      );
}
