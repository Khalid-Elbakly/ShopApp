import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/'));
  }

  static Future<Response> getData(
      {required String url, lang = 'en', token}) async {
    dio.options.headers = {'lang': lang, 'Authorization': token, 'Content-Type' : 'application/json'};
    return await dio.get(url);
  }

  static Future<Response> postData(
      {required String url,
      lang = 'en',
      token,
      required Map<String, dynamic> data}) {
    dio.options.headers = {'lang': lang, 'Authorization': token,'Content-Type': 'application/json'};
    return dio.post(url, data: data);
  }

  static Future<Response> putData(
      {required String url,
        lang = 'en',
        token,
        required Map<String, dynamic> data}) {
    dio.options.headers = {'lang': lang, 'Authorization': token,'Content-Type': 'application/json'};
    return dio.put(url, data: data);
  }
}
