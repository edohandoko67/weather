import 'package:get/get.dart';
import 'package:weather_apps/view/home/home.controller.dart';
import 'package:weather_apps/view/home/home.dart';
import 'package:weather_apps/view/verif/splash.dart';
import 'package:weather_apps/view/verif/verify.dart';

part 'routes.dart';

List<GetPage> pages = [
  GetPage(name: Routes.init, page: () => const Verify(), binding: HomeBindings()),
  GetPage(name: Routes.home, page: () => const HomePage(), binding: HomeBindings()),
  GetPage(name: Routes.splash, page: () => const SplashScreen()),
];