import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_apps/routes/pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'auth/provider/cache.provider.dart';
import 'auth/utils/storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Menyimpan token
  // String token = "0eebf592bc10442ab0c25754241811";
  // Storage.token = token;
  //
  // // Mengambil token
  // print("Stored Token: ${Storage.token}");  // Output: Stored Token: thisIsTheTokenValue12345

  // // Mengosongkan token
  // Storage.clearToken();
  // print("Token after clearing: ${Storage.token}");  // Output: Token after clearing:
  await GetStorage.init();
  await AppPathProvider.initPath();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}
void loadingInstance() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 2)
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..progressColor = Colors.green
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.green
    ..textColor = Colors.green
    ..maskColor = Colors.green.withOpacity(0.5)
    ..userInteractions = true
    ..boxShadow = [
      BoxShadow(
        color: Colors.grey.withOpacity(0.8),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(1, 4),
      )
    ]
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("id", "")
      ],
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
      ),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
      initialRoute: Routes.splash,
      getPages: pages,
      builder: EasyLoading.init(), //init dahulu
    );
  }
}

