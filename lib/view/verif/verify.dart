import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../home/home.controller.dart';

class Verify extends GetView<HomeController> {
  const Verify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                controller.getCurrentLocationAndFetchWeather();
              },
              child: const Text('Lanjut')),
        ),
      ),
    );
  }
}