import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> getData(
      {required String url, lang = 'en', token}) async {
    dio.options.headers = {'lang': lang, 'Authorization': token};
    return await dio.get(url);
  }

  static Future<Response> postData(
      {required String url,
      lang = 'en',
      token,
      required Map<String, dynamic> data}) {
    dio.options.headers = {'lang': lang, 'Authorization': token};
    return dio.post(url, data: data);
  }
}
