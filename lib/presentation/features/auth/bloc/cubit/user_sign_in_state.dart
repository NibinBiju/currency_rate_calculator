part of 'user_sign_in_cubit.dart';

@immutable
sealed class UserSignInState {}

final class UserSignInInitial extends UserSignInState {}

final class UserSignInLoading extends UserSignInState {}

final class UserSignInFailed extends UserSignInState {
  final String message;

  UserSignInFailed({required this.message});
}

final class UserSignInSuccess extends UserSignInState {
  final String message;

  UserSignInSuccess({required this.message});
}
