import 'package:currency_rate_calculator/data/source/currency_convert_source.dart';
import 'package:currency_rate_calculator/domain/entity/currency_convert_entity.dart';
import 'package:currency_rate_calculator/domain/repository/currency_converter_repo.dart';
import 'package:currency_rate_calculator/get_service_locator.dart';
import 'package:dartz/dartz.dart';

class CurrencyConverterRepositoryImpl extends CurrencyConverterRepository {
  @override
  Future<Either<String, Map<String, dynamic>>> convertCurrency({
    required CurrencyConvertEntity currencyConvertEntity,
  }) async {
    var retunredData = await getIt<CurrencyConvertSource>().convertCurrency(
      currencyConvertEntity: currencyConvertEntity,
    );

    return retunredData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }
}
