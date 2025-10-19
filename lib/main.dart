import 'package:currency_rate_calculator/core/theme/app_theme.dart';
import 'package:currency_rate_calculator/init.dart';
import 'package:currency_rate_calculator/presentation/features/auth/bloc/cubit/user_sign_in_cubit.dart';
import 'package:currency_rate_calculator/presentation/features/home/bloc/bloc/currency_convert_bloc.dart';
import 'package:currency_rate_calculator/presentation/features/splash_page/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserSignInCubit>(create: (context) => UserSignInCubit()),
        BlocProvider<CurrencyConvertBloc>(
          create: (context) => CurrencyConvertBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Currency Converter App',
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const SplashPage(),
      ),
    );
  }
}
