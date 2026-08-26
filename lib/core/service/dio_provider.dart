import 'package:dio/dio.dart';
import 'package:my_tasks/core/helper/cache_helper.dart';
import 'package:my_tasks/core/service/apis.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Apis.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 20),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = CacheHelper.getData(key: 'token');
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
      ),
    );
  }

  static Future<Response> post({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParametars,
  }) {
    return dio.post(
      endPoint,
      data: data,
      options: Options(headers: header),
      queryParameters: queryParametars,
    );
  }

  static Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParametars,
  }) {
    return dio.get(
      endPoint,
      data: data,
      options: Options(headers: header),
      queryParameters: queryParametars,
    );
  }

  static Future<Response> put({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParametars,
  }) {
    return dio.put(
      endPoint,
      data: data,
      options: Options(headers: header),
      queryParameters: queryParametars,
    );
  }
}