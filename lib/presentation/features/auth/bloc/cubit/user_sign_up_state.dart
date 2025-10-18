part of 'user_sign_up_cubit.dart';

@immutable
sealed class UserSignUpState {}

final class UserSignUpInitial extends UserSignUpState {}

final class UserSignUpLoading extends UserSignUpState {}

final class UserSignUpSuccess extends UserSignUpState {
  final String message;

  UserSignUpSuccess({required this.message});
}

final class UserSignUpFailed extends UserSignUpState {
  final String message;

  UserSignUpFailed({required this.message});
}
