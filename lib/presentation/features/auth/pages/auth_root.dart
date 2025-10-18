import 'package:currency_rate_calculator/presentation/features/auth/bloc/cubit/user_sign_in_cubit.dart';
import 'package:currency_rate_calculator/presentation/features/auth/bloc/cubit/user_sign_up_cubit.dart';
import 'package:currency_rate_calculator/presentation/features/auth/pages/sign_in_page.dart';
import 'package:currency_rate_calculator/presentation/features/auth/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthRoot extends StatefulWidget {
  const AuthRoot({super.key});

  @override
  State<AuthRoot> createState() => _AuthRootState();
}

class _AuthRootState extends State<AuthRoot> {
  bool isSigninPage = true;

  void _onTap() {
    setState(() {
      isSigninPage = !isSigninPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSigninPage) {
      return SignInPage(onTap: _onTap);
    } else {
      return BlocProvider(
        create: (context) => UserSignUpCubit(),
        child: SignUpPage(onTap: _onTap),
      );
    }
  }
}
