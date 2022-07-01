import 'package:dio/dio.dart';
import 'package:news_test_with_cubit_dio/const.dart';

class DioHelper {
  static Dio? _dio;

  static init() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }
  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query,
        String? Token}) {
    _dio!.options.headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Authorization": Token
    };
    return _dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
        required Map<String, dynamic> data,
        Map<String, dynamic>? query,
        String? Token
      }) {
    _dio!.options.headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Authorization": Token
    };
    return _dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData(
      {required String url,
        Map<String, dynamic>? data,
        Map<String, dynamic>? query,
        String? Token
      }) {
    _dio!.options.headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Authorization": Token
    };
    return _dio!.delete(url, queryParameters: query, data: data);
  }
}