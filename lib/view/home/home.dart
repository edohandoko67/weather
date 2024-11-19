import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_apps/view/home/home.controller.dart';


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
                      Color(0xFF3c3c3c),
                      // Warna gelap, bisa menggambarkan awan gelap
                      Color(0xFF607D8B),
                      // Warna abu-abu kebiruan, menggambarkan hujan
                      Color(0xFF90A4AE),
                      // Warna biru muda, menggambarkan hujan ringan
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

                      // Tombol untuk memperbarui cuaca
                      // ElevatedButton(
                      //   //onPressed: controller.updateWeather,
                      //   onPressed: () {},
                      //   child: Text('Update Weather'),
                      //   style: ElevatedButton.styleFrom(
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
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: IconButton(
                            onPressed: () {
                              controller.showButtonPopup(context);
                            },
                            icon: Image.asset('assets/images/maps.png'),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Obx(() =>
                            Text(
                                controller.cloudWeather.value.locations?.name
                                    ?.toString() ?? '0',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.white
                                )
                            ),),
                      ],
                    ),
                    Obx(() {
                      // Mendapatkan localtime yang mungkin berupa String
                      final localtimeString = controller.cloudWeather.value
                          .locations?.localtime;

                      // Cek apakah localtimeString tidak null dan format menjadi DateTime
                      String formattedDate = localtimeString != null
                          ? DateFormat('EEEE, dd-MM-yyyy HH:mm', 'id_ID')
                          .format(DateTime.parse(
                          localtimeString)) // Parse string ke DateTime dan format
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
                        Obx(() =>
                            Text(
                              '${controller.cloudWeather.value.currents?.celcius
                                  ?.toStringAsFixed(1) ?? '0.0'} C',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
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
                    Obx(() =>
                        Text(controller.cloudWeather.value.currents?.conditions
                            ?.txt ?? '',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.grey[400]
                          ),
                        ),),
                    Obx(() =>
                        Text(
                          'Terasa seperti ${controller.cloudWeather.value
                              .currents?.feelsCelcius ?? ''} C',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.grey[400]
                          ),
                        ),),
                  ],
                ),
              ),
              Positioned(
                bottom: 300,
                left: 7,
                child: SizedBox(
                  width: 400, // Set a larger width for better visibility
                  height: 200,
                  child:
                    // // Ensure data is available before building ListView
                    // if (controller.listcloudWeather.isEmpty) {
                    //   return Center(
                    //       child: Text("No data available", style: TextStyle(
                    //           color: Colors.white)));
                    // }

                    Expanded(
                      child: Obx(() => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.listcloudWeather.length,
                        itemBuilder: (context, index) {
                          final item = controller.listcloudWeather[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            // Add padding between items
                            child: Column(
                              children: [
                                Text(
                                  item.time.toString(),
                                  // item.time != null
                                  //     ? DateFormat('HH:mm').format(
                                  //   DateTime.fromMillisecondsSinceEpoch(
                                  //     int.tryParse(item.time!) ?? 0, // Safely parse the string, fallback to 0 if invalid
                                  //   ),
                                  // )
                                  //     : '00:00', // Fallback if `item.time` is null or empty
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset(
                                    _getWeatherImage(item.txt?.txtWeather),
                                  ),
                                ),
                                // Format and display the temperature as time (HH:mm)
                                // If item.temp_c is not a timestamp, we need to display it as a default value.
                                Text(
                                  "${item.temp_c?.toStringAsFixed(1) ?? '0.0'} C", // Default value if temp_c is null
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: Image.asset('assets/images/water.png')),
                                    Text(
                                      '${(int.tryParse(item.humidity.toString()) ?? 0)} %',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                // Text(
                                //   item.forecast?.forecastday
                                //       ?.expand((e) => e.hours!)
                                //       .map((e) => e.time)
                                //       .join(', ') ?? 'No hours available', // Fallback text if no hours
                                //   style: GoogleFonts.poppins(
                                //     fontSize: 15,
                                //     color: Colors.white,
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),),
                      ),
                    ),
                  ),
              Positioned(
                bottom: 200,
                left: 40,
                right: 40,
                child: Column(
                  children: [
                    // Indeks UV
                    Row(
                      children: [
                        const Icon(
                          Icons.sunny,
                          color: Colors.yellow,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Indeks UV',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Obx(() => Text(
                          "${controller.cloudWeather.value.currents?.uv ?? 'High'}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(height: 7),

                    // Sunset
                    Row(
                      children: [
                        const Icon(
                          Icons.sunny_snowing,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Sunset',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Obx(() => Text(
                          controller.astrodWeather.value.sunset ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(height: 7),

                    // Sunrise
                    Row(
                      children: [
                        const Icon(
                          Icons.sunny_snowing,
                          color: Colors.yellowAccent,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Sunrise',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Obx(() => Text(
                          controller.astrodWeather.value.sunrise ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(height: 7),

                    // Wind
                    Row(
                      children: [
                        const Icon(
                          Icons.wind_power,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Wind',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Obx(() => Text(
                          "${controller.cloudWeather.value.currents?.wind ?? ''} kph",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(height: 7),

                    // Humidity
                    Row(
                      children: [
                        const Icon(
                          Icons.water_drop_sharp,
                          color: Colors.blue,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Humidity',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Obx(() => Text(
                          "${controller.cloudWeather.value.currents?.humidity ?? ''} %",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),

            ]),
      ),
    );
  }
  String _getWeatherImage(String? weatherCondition) {
    switch (weatherCondition) {
      case 'Patchy rain nearby':
        return 'assets/images/raining.png';
      case 'Patchy light drizzle':
        return 'assets/images/raining_lighty.png';
      case 'Moderate or heavy rain shower':
        return 'assets/images/petir.png';
      default:
        return 'assets/images/cloudy.png'; // Gambar default
    }
  }
}
