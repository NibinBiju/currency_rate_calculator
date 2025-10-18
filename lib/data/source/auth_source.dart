import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthSource {
  Future<Either> userSignIn({required String email, required String password});
  Future<Either> userSignUp({required String email, required String password});
}

class AuthSourceImpl extends AuthSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either> userSignIn({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right('User Sign In SuccessFully');
    } catch (e) {
      print("Error: $e");
      return Left('An unknown error occurred: $e');
    }
  }

  @override
  Future<Either> userSignUp({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right('User Sign Up SuccessFully');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          // The email address is not valid.
          print('The email address is not valid.');
          return Left('The email address is not valid.');
        case 'wrong-password':
          // The password is incorrect.
          print('The password is incorrect.');
          return Left('The password is incorrect.');

        case 'user-not-found':
          // There is no user record corresponding to the given email.
          print('No user found with this email.');
          return Left('No user found with this email.');

        case 'user-disabled':
          // The user account has been disabled.
          print('This user account has been disabled.');
          return Left('This user account has been disabled.');

        case 'too-many-requests':
          // Too many requests have been made.
          print('Too many requests. Try again later.');
          return Left('Too many requests. Try again later.');

        case 'operation-not-allowed':
          // Email/password accounts are not enabled.
          print('Email and password sign-in is not enabled.');
          return Left('Email and password sign-in is not enabled.');

        default:
          // Handle other cases.
          print('An unknown error occurred: ${e.message}');
          return Left('An unknown error occurred: ${e.message}');
      }
    }
  }
}
