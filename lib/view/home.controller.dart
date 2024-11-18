import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:weather_apps/auth/model/cloud.dart';
import 'package:weather_apps/auth/service/auth.service.dart';
import 'package:weather_apps/auth/utils/storage.dart';

import '../routes/pages.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  AuthService service = AuthService();
  Storage storage = Storage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Rx<Cloud> cloudWeather = Cloud().obs;
  Future<void> weather() async {
    String token = Storage.token;
    cloudWeather.value = await service.cloudWeather({
      'q': 'mojokerto',
      'key': token,
    });
    if (cloudWeather != null ) {
      Get.toNamed(Routes.home);
    } else {
      EasyLoading.showError('Gagal mendapatkan data cuaca. Coba lagi!');
    }
  }
}