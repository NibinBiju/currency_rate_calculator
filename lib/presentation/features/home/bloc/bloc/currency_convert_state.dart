part of 'currency_convert_bloc.dart';

@immutable
sealed class CurrencyConvertState {}

final class CurrencyConvertInitial extends CurrencyConvertState {}

final class CurrencyConvertLoading extends CurrencyConvertState {}

final class CurrencyConvertFailed extends CurrencyConvertState {
  final String message;

  CurrencyConvertFailed({required this.message});
}

final class CurrencyConvertSuccess extends CurrencyConvertState {
  final Map<String, dynamic> data;

  CurrencyConvertSuccess({required this.data});
}
