import 'package:dio/dio.dart';

import 'endpoints.dart';


abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio() {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {
        'Content-Type': 'application/json; charset=utf-8',
      }
    ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true))
      ..interceptors.add(
        InterceptorsWrapper(onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {

          return handler.next(options);
        }, onError: (DioError error, ErrorInterceptorHandler handler) async {
          return handler.next(error);
        }),
      );

    return dio;
  }
}
