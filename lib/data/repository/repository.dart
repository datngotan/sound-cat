
import 'package:dio/dio.dart';

import '../model/race_detail.dart';
import '../model/water_param.dart';

class Repository {
  Repository._();
  static const baseUrl = 'https://api.uuggaa.com';
  static const pathUrl = '/a/hk/waterparams.json';

  static Future<WaterParam?> getWaterParam() async {
    try {
      final response = await client.get(pathUrl);
      if (response.statusCode == 200) {
        dynamic json = response.data;
        WaterParam waterParam = WaterParam.fromJson(json);
        return waterParam;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  
  static Future<RaceDetails?> getRaceDetail(String url) async {
    try {
      final response = await Dio(BaseOptions(baseUrl: url)).get('');
      if (response.statusCode == 200) {
        dynamic json = response.data;
        RaceDetails raceDetail = RaceDetails.fromJson(json);
        return raceDetail;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<String?> get(String url) async {
    try {
      final response = await Dio(BaseOptions(baseUrl: url)).get('');
      if (response.statusCode == 200) {
        String result = response.data;
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Dio get client => Dio(BaseOptions(baseUrl: baseUrl));
}
