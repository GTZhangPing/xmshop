
import 'package:dio/dio.dart';

 class HttpsClient {
  static String domain = 'https://xiaomi.itying.com/';
  static Dio dio = Dio();
  HttpsClient() {
    dio.options.baseUrl = domain;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future get(String url) async {
    try {
      var response = await dio.get(url);
      return response;
    } catch (e) {
      print("请求超时");
      return null;
    }
  }

   Future post(String url,{Map? data}) async {
    try {
      var response = await dio.post(url,data: data);
      return response;
    } catch (e) {
      print("请求超时");
      return null;
    }
  }

static replaeUri(url) {
  String tempUrl = domain+url;
  return tempUrl.replaceAll('\\', '/');
}

}
