import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_apps/auth/model/cloud.dart';
import 'package:weather_apps/auth/service/auth.service.dart';
import 'package:weather_apps/auth/utils/storage.dart';

import '../../routes/pages.dart';

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
    getCurrentLocationAndFetchWeather();
  }

  // Rx untuk menampung teks pencarian
  var searchQuery = ''.obs;

  // Rx untuk menampung hasil pencarian (misalnya daftar data)
  var searchResult = <String>[].obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    // fetchDataFromApi(query);
  }

  // Future<void> fetchDataFromApi(String query) async {
  //   if (query.isEmpty) {
  //     searchResult.value = []; // Jika query kosong, hasil pencarian juga kosong
  //     return;
  //   }
  //
  //   try {
  //     String token = "your_api_token_here"; // Ganti dengan token API Anda
  //     var response = await http.get(
  //       Uri.parse('https://api.example.com/search?q=$query&key=$token'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //
  //       // Anggaplah response body berisi daftar hasil pencarian dalam field "items"
  //       List<String> items = List<String>.from(data['items'].map((item) => item['name']));
  //
  //       searchResults.value = items; // Update hasil pencarian
  //     } else {
  //       EasyLoading.showError('Failed to fetch data');
  //       searchResults.value = []; // Menampilkan hasil kosong jika API gagal
  //     }
  //   } catch (e) {
  //     EasyLoading.showError('Error: $e');
  //     searchResults.value = []; // Menampilkan hasil kosong jika ada error
  //   }
  // }

  void showButtonPopup(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true, // Untuk menutup dialog ketika klik di luar dialog
      barrierColor: Colors.black.withOpacity(0.2), // Background transparan di luar dialog
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Sesuaikan bentuk dialog
          ),
          backgroundColor: Colors.transparent, // Membuat dialog background transparan
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Membuat ukuran dialog menyesuaikan kontennya
              crossAxisAlignment: CrossAxisAlignment.stretch, // Agar elemen dalam dialog tersusun rapi
              children: [
                // Search Field
                TextField(
                  onChanged: (query) {
                    // Handle the search query change
                  },
                  decoration: const InputDecoration(
                    labelText: 'Search...',
                    hintText: 'Search something...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getCurrentLocationAndFetchWeather() async {
    String token = "0eebf592bc10442ab0c25754241811";
    Storage.token = token;

    // Mengambil token
    print("Stored Token: ${Storage.token}");  // Output: Stored Token: thisIsTheTokenValue12345
    bool serviceEnabled;
    LocationPermission permission;

    // Memeriksa apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      EasyLoading.showError('Layanan lokasi tidak diaktifkan');
      return;
    }

    // Memeriksa izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        EasyLoading.showError('Permission ditolak');
        return;
      }
    }

    // Jika izin lokasi diberikan, dapatkan posisi pengguna
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      // Memanggil fungsi weather dengan q menggunakan lokasi yang terdeteksi (latitude dan longitude)
      await weather(position.latitude, position.longitude);
      await weathers(position.latitude, position.longitude);
      await astroWeathers(position.latitude, position.longitude);
    } else {
      EasyLoading.showError('Izin lokasi tidak tersedia');
    }
  }


  Rx<Cloud> cloudWeather = Cloud().obs;
  Future<void> weather(double latitude, double longitude) async {
    String token = Storage.token;
    cloudWeather.value = await service.cloudWeather({
      'q': '$latitude,$longitude',
      'key': token,
    });
    print('indeks uv: ${cloudWeather.value.currents?.uv}');
    if (cloudWeather != null ) {
      Get.toNamed(Routes.home);
    } else {
      EasyLoading.showError('Gagal mendapatkan data cuaca. Coba lagi!');
    }
  }

  RxList<Hour> listcloudWeather = <Hour>[].obs;
  Future<void> weathers(double latitude, double longitude) async {
    String token = Storage.token;
    listcloudWeather.value = await service.cloudForecast({
      'q': '$latitude,$longitude',
      'key': token,
    });
  }

  Rx<Astro> astrodWeather = Astro().obs;
  Future<void> astroWeathers(double latitude, double longitude) async {
    String token = Storage.token;
    astrodWeather.value = await service.cloudAstro({
      'q': '$latitude,$longitude',
      'key': token,
    });
    print('sunset: ${astrodWeather.value.sunset}');
  }


}