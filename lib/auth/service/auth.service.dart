import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:weather_apps/auth/model/cloud.dart';

import '../provider/api.provider.dart';
import 'api.constant.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;

class AuthService {
  HttpClient httpClient = HttpClient(baseUrl: ApiConstant.baseUrl);

  Future<Cloud> cloudWeather(Map<String, dynamic> data) async {
    try {
      dio.Response response = await httpClient.post(ApiConstant.currentWeather, data: data, useFormData: true );
      final body = response.data;
      if (body != null) {
        return Cloud.fromJson(body);
      } else {
        throw Exception('Failed to retrieve Cloud data');
      }
    } on dio.DioError catch(_) {
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal terhubung ke Server. Coba lagi!');
      throw Exception(_.message);
    }
  }

  Future<List<Hour>> cloudForecast(Map<String, dynamic> data) async {
    try {
      dio.Response response = await httpClient.post(ApiConstant.forecast, data: data, useFormData: true);
      final body = response.data;

      // Ensure body is a Map and contains the expected forecast structure
      if (body != null && body is Map) {
        var forecast = body['forecast'];
        if (forecast != null && forecast is Map) {
          var forecastday = forecast['forecastday'];
          // Ensure forecastday is a List
          if (forecastday is List) {
            // Now, map over the forecastday and flatten hours into a single list
            List<Hour> hours = forecastday
                .where((e) => e['hour'] is List) // Ensure 'hour' exists as a list
                .expand((e) => (e['hour'] as List).map((data) => Hour.fromJson(data))) // Convert each item to Hour
                .toList();
            return hours;
          } else {
            throw Exception('forecastday is not a List');
          }
        } else {
          throw Exception('forecast is missing or is not a Map');
        }
      } else {
        throw Exception('Body is null or not a Map');
      }
    } on dio.DioError catch (_) {
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal terhubung ke Server. Coba lagi!');
      throw Exception(_.message);
    }
  }



}