import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

class NetworkService {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "https://api.unsplash.com";
  static String SERVER_PRODUCTION = "https://api.unsplash.com";

  static Map<String, String> getHeaders() {
    Map<String, String> headers = {
      "Authorization" : "Client-ID mT8hj53DywChJkbscZAN5aHio9v2M9impW_i-VIc7vs"
    };
    return headers;
  }

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /// /* Http Requests */

  static Future<String?> GET() async {
    try {
      var response = await Dio(BaseOptions(
              baseUrl: getServer(),
              validateStatus: (status) => status! < 203,
              headers: getHeaders()))
          .get("/photos/random")
          .timeout(const Duration(seconds: 20), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      return jsonEncode(response.data);
    } on DioError catch (e) {
      print(e.toString());
      return null;
    }
  }

}
