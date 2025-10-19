import 'package:currency_rate_calculator/core/configs/env.dart';
import 'package:currency_rate_calculator/core/services/dio_services.dart';
import 'package:currency_rate_calculator/domain/entity/currency_convert_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyConvertSource {
  Future<Either<String, Map<String, dynamic>>> convertCurrency({
    required CurrencyConvertEntity currencyConvertEntity,
  });
}

class CurrencyConvertSourceImpl extends CurrencyConvertSource {
  @override
  Future<Either<String, Map<String, dynamic>>> convertCurrency({
    required CurrencyConvertEntity currencyConvertEntity,
  }) async {
    final accessKey = Env.accessKey;
    try {
      print(
        'Request URL: ${ApiService().dio.options.baseUrl}/convert?from=${currencyConvertEntity.from}&to=${currencyConvertEntity.to}&amount=${currencyConvertEntity.amount}&access_key=$accessKey',
      );
      final response = await ApiService().getRequest(
        endpoint: '/convert',
        queryParameters: {
          'from': currencyConvertEntity.from,
          'to': currencyConvertEntity.to,
          'amount': currencyConvertEntity.amount,
          'access_key': accessKey,
        },
      );

      print('Response: ${response.data}');

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left('Error: Unexpected response.');
      }
    } catch (e) {
      print('Error converting currency: $e');
      return Left('Error converting currency: $e');
    }
  }
}
