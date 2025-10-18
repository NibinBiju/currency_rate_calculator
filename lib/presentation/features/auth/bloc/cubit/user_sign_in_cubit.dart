import 'package:currency_rate_calculator/data/model/user_auth_model.dart';
import 'package:currency_rate_calculator/domain/usecase/auth/sign_in_usecase.dart';
import 'package:currency_rate_calculator/get_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_sign_in_state.dart';

class UserSignInCubit extends Cubit<UserSignInState> {
  UserSignInCubit() : super(UserSignInInitial());

  void userSignIn({required UserAuthModel userAuthModel}) async {
    var returnedData = await getIt<SignInUsecase>().call(params: userAuthModel);
    return returnedData.fold(
      (error) {
        emit(UserSignInFailed(message: error));
      },
      (data) {
        emit(UserSignInSuccess(message: data));
      },
    );
  }
}
