import 'package:currency_rate_calculator/domain/entity/currency_convert_entity.dart';
import 'package:currency_rate_calculator/domain/usecase/currency_convert_usecase/currency_convert_usecase.dart';
import 'package:currency_rate_calculator/get_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'currency_convert_event.dart';
part 'currency_convert_state.dart';

class CurrencyConvertBloc
    extends Bloc<CurrencyConvertEvent, CurrencyConvertState> {
  CurrencyConvertBloc() : super(CurrencyConvertInitial()) {
    on<OnCurrencyConvertEvent>((event, emit) async {
      emit(CurrencyConvertLoading());
      var retunredData = await getIt<CurrencyConvertUsecase>().call(
        params: event.currencyConvertEntity,
      );

      return retunredData.fold(
        (error) {
          emit(CurrencyConvertFailed(message: error));
        },
        (data) {
          emit(CurrencyConvertSuccess(data: data));
        },
      );
    });
  }
}
