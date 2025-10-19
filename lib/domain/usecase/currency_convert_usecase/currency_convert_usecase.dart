import 'package:currency_rate_calculator/core/usecase/usecase.dart';
import 'package:currency_rate_calculator/domain/entity/currency_convert_entity.dart';
import 'package:currency_rate_calculator/domain/repository/currency_converter_repo.dart';
import 'package:currency_rate_calculator/get_service_locator.dart';
import 'package:dartz/dartz.dart';

class CurrencyConvertUsecase extends Usecase<Either, CurrencyConvertEntity> {
  @override
  Future<Either<String, Map<String, dynamic>>> call({
    CurrencyConvertEntity? params,
  }) async {
    var returnedData = await getIt<CurrencyConverterRepository>()
        .convertCurrency(
          currencyConvertEntity: CurrencyConvertEntity(
            from: params?.from ?? '',
            to: params?.to ?? "",
            amount: params?.amount ?? "",
          ),
        );
    return returnedData.fold(
      (error) {
        return Left(error.toString());
      },
      (data) {
        return Right(data);
      },
    );
  }
}
