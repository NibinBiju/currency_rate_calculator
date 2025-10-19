import 'package:currency_rate_calculator/data/source/auth_source.dart';
import 'package:currency_rate_calculator/domain/repository/auth_repo.dart';
import 'package:currency_rate_calculator/get_service_locator.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> userSignIn({
    required String email,
    required String password,
  }) async {
    var returnedData = await getIt<AuthSource>().userSignIn(
      email: email,
      password: password,
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

  @override
  Future<Either> userSignUp({
    required String email,
    required String password,
  }) async {
    var returnedData = await getIt<AuthSource>().userSignUp(
      email: email,
      password: password,
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
  
  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
