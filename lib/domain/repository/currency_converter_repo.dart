import 'package:currency_rate_calculator/domain/entity/currency_convert_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyConverterRepository {
  Future<Either<String, Map<String, dynamic>>> convertCurrency({
    required CurrencyConvertEntity currencyConvertEntity,
  });
}
