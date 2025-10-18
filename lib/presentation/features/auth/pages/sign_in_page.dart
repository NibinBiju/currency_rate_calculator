// ignore_for_file: use_build_context_synchronously

import 'package:currency_rate_calculator/common/helper/validator.dart';
import 'package:currency_rate_calculator/core/configs/app_colors.dart';
import 'package:currency_rate_calculator/core/services/navigation_services.dart';
import 'package:currency_rate_calculator/data/model/user_auth_model.dart';
import 'package:currency_rate_calculator/presentation/features/auth/bloc/cubit/user_sign_in_cubit.dart';
import 'package:currency_rate_calculator/presentation/features/home/pages/home_page.dart';
import 'package:currency_rate_calculator/presentation/widget/app_text_field.dart';
import 'package:currency_rate_calculator/presentation/widget/custom_app_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, this.onTap});

  final void Function()? onTap;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _emailEditingController = TextEditingController();

  final TextEditingController _passwordEditingController =
      TextEditingController();

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: 200,
              child: CircleAvatar(
                radius: 800,
                backgroundColor: AppColors.accentDark,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.09),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.25,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.25,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: height * 0.17),
                    authField(
                      fieldHint: "Enter email",
                      headline: 'Email',
                      textEditingController: _emailEditingController,
                      validator: (value) =>
                          Validation.validateEmail(email: value ?? ""),
                    ),
                    SizedBox(height: height * 0.02),
                    authField(
                      fieldHint: "Enter Password",
                      headline: 'Password',
                      textEditingController: _passwordEditingController,
                      isPassword: true,
                      validator: (value) =>
                          Validation.validatePassword(password: value ?? ""),
                    ),
                    SizedBox(height: height * 0.13),
                    BlocConsumer<UserSignInCubit, UserSignInState>(
                      listener: (context, state) {
                        if (state is UserSignInFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                        if (state is UserSignInSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                          Future.delayed(Duration(seconds: 1), () {
                            NavigatorWidget.pushAndRemovePages(
                              context: context,
                              page: HomePage(),
                            );
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is UserSignInLoading) {
                          return CustomAppButton(buttonText: 'Loading');
                        }
                        return CustomAppButton(
                          buttonText: 'Login',
                          onTap: () => onLogin(context),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_signUpNewUser(context)],
                    ),
                    SizedBox(height: height * 0.04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onLogin(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      context.read<UserSignInCubit>().userSignIn(
        userAuthModel: UserAuthModel(
          email: _emailEditingController.text.trim(),
          password: _passwordEditingController.text.trim(),
        ),
      );
    }
  }

  RichText _signUpNewUser(BuildContext context) {
    return RichText(
      textAlign: TextAlign.end,
      text: TextSpan(
        children: [
          TextSpan(
            text: "New User?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.25,
              color: Colors.white,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = widget.onTap,
            text: " Sign up",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.25,
              color: AppColors.accentBlue,
            ),
          ),
        ],
      ),
    );
  }

  Column authField({
    required String headline,
    required String fieldHint,
    required TextEditingController textEditingController,
    bool? isPassword,
    String? Function(String?)? validator,
  }) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headline,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.25,
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
        AppTextField(
          validator: validator,
          isPassword: isPassword ?? false,
          textEditingController: textEditingController,
          hintText: fieldHint,
        ),
      ],
    );
  }
}
