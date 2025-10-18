import 'package:currency_rate_calculator/data/repository_impl/auth_repo_impl.dart';
import 'package:currency_rate_calculator/data/source/auth_source.dart';
import 'package:currency_rate_calculator/domain/repository/auth_repo.dart';
import 'package:currency_rate_calculator/domain/usecase/auth/sign_in_usecase.dart';
import 'package:currency_rate_calculator/domain/usecase/auth/sign_up_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initializeDependecies() {
  //auth
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<AuthSource>(AuthSourceImpl());
  getIt.registerSingleton<SignUpUsecase>(SignUpUsecase());
  getIt.registerSingleton<SignInUsecase>(SignInUsecase());
}
