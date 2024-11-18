import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../model/cloud.dart';
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
}