import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_apps/view/home.controller.dart';


class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF3c3c3c), // Warna gelap, bisa menggambarkan awan gelap
                  Color(0xFF607D8B), // Warna abu-abu kebiruan, menggambarkan hujan
                  Color(0xFF90A4AE), // Warna biru muda, menggambarkan hujan ringan
                ],
                stops: [0.0, 0.5, 1.0], // Membagi gradasi menjadi 3 bagian
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Text('Cuaca', style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.white
                    ),),
                  ),


                  // Ikon cuaca dan suhu
                  // Obx(() => Column(
                  //   children: [
                  //     Icon(
                  //       Icons.wb_sunny, // Ganti dengan ikon cuaca yang sesuai
                  //       size: 80,
                  //       color: Colors.orange,
                  //     ),
                  //     Text(
                  //       controller.temperature.value,
                  //       style: TextStyle(
                  //         fontSize: 60,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     Text(
                  //       controller.condition.value,
                  //       style: TextStyle(
                  //         fontSize: 24,
                  //         color: Colors.black54,
                  //       ),
                  //     ),
                  //   ],
                  // )),

                  SizedBox(height: 40),

                  // Tombol untuk memperbarui cuaca
                  // ElevatedButton(
                  //   onPressed: controller.updateWeather,
                  //   child: Text('Update Weather'),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.blue,
                  //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  //     textStyle: TextStyle(fontSize: 18),
                  //   ),
                  // ),
                ],
              ),

            ),
          ),
            Positioned(
              top: 100,
              left: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                    controller.cloudWeather.value.locations?.name?.toString() ?? '0',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white
                    )
                  )),
                  Obx(() {
                    // Mendapatkan localtime yang mungkin berupa String
                    final localtimeString = controller.cloudWeather.value.locations?.localtime;

                    // Cek apakah localtimeString tidak null dan format menjadi DateTime
                    String formattedDate = localtimeString != null
                        ? DateFormat('EEEE, dd-MM-yyyy HH:mm', 'id_ID').format(DateTime.parse(localtimeString)) // Parse string ke DateTime dan format
                        : '0'; // Fallback jika localtimeString null

                    return Text(
                      formattedDate,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.grey[100]
                      )
                    );
                  }),
                  Row(
                    children: [
                      SizedBox(
                          width: 80,
                          height: 65,
                          child: Image.asset('assets/images/raining.png')),
                      Text(
                        '${controller.cloudWeather.value.currents?.celcius?.toStringAsFixed(1) ?? '0.0'} C',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 150,
              right: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(controller.cloudWeather.value.currents?.conditions?.txt ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey[400]
                    ),
                  ),
                  Text(
                    'Terasa seperti ${controller.cloudWeather.value.currents!.feelsCelcius ?? ''} C',
                    style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.grey[400]
                    ),
                  )
                ],
              ),
            )
        ]),
      ),
    );
  }
}
