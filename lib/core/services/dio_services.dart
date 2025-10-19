import 'package:currency_rate_calculator/core/configs/env.dart';
import 'package:dio/dio.dart';

class ApiService {
  final String accessKey = Env.accessKey;
  final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: Env.baseUrl,
            connectTimeout: Duration(seconds: 5),
            receiveTimeout: Duration(seconds: 5),
            headers: {'Accept': 'application/json'},
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              print('Final URL: ${options.uri}');
              return handler.next(options);
            },
          ),
        );

  Future<Response> getRequest({
    required String endpoint,
    required Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('GET request failed: ${e.message}');
    }
  }
}
