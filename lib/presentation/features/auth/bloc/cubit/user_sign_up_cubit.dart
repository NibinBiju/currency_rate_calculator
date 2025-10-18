import 'package:currency_rate_calculator/data/model/user_auth_model.dart';
import 'package:currency_rate_calculator/domain/usecase/auth/sign_up_usecase.dart';
import 'package:currency_rate_calculator/get_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_sign_up_state.dart';

class UserSignUpCubit extends Cubit<UserSignUpState> {
  UserSignUpCubit() : super(UserSignUpInitial());

  void userSignUp({required UserAuthModel userAuthModel}) async {
    var returnedData = await getIt<SignUpUsecase>().call(params: userAuthModel);
    return returnedData.fold(
      (error) {
        emit(UserSignUpFailed(message: error));
      },
      (data) {
        emit(UserSignUpSuccess(message: data));
      },
    );
  }
}
