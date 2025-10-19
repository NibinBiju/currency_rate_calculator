import 'package:currency_rate_calculator/core/usecase/usecase.dart';
import 'package:currency_rate_calculator/domain/entity/user_auth_model.dart';
import 'package:currency_rate_calculator/domain/repository/auth_repo.dart';
import 'package:currency_rate_calculator/get_service_locator.dart';
import 'package:dartz/dartz.dart';

class SignInUsecase extends Usecase<Either, UserAuthModel> {
  @override
  Future<Either> call({UserAuthModel? params}) async {
    var returnedData = await getIt<AuthRepository>().userSignIn(
      email: params?.email ?? "",
      password: params?.password ?? "",
    );
    return returnedData.fold(
      (error) {
        return Left(error.toString());
      },
      (data) {
        return Right(data.toString());
      },
    );
  }
}
