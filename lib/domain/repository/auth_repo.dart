import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> userSignIn({required String email, required String password});
  Future<Either> userSignUp({required String email, required String password});

}