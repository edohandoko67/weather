import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/utils/storage.dart';
import '../../routes/pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
      setState(() {});
    });

    controller.forward().whenComplete(() async {
      String token = Storage.token;
      if (token != null) {
        Get.toNamed(Routes.home);
      } else {
        Get.toNamed(Routes.init);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold();
  }
}
