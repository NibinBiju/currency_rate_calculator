part of 'currency_convert_bloc.dart';

@immutable
sealed class CurrencyConvertEvent {}

final class OnCurrencyConvertEvent extends CurrencyConvertEvent {
  final CurrencyConvertEntity currencyConvertEntity;

  OnCurrencyConvertEvent({required this.currencyConvertEntity});
}
