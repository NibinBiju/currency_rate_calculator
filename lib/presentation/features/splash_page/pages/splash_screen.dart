import 'package:currency_rate_calculator/core/configs/app_colors.dart';
import 'package:currency_rate_calculator/core/services/navigation_services.dart';
import 'package:currency_rate_calculator/presentation/features/auth/pages/auth_root.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.initialPayload});
  final String? initialPayload;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _zoomOutAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _zoomOutAnimation = Tween<double>(
      begin: 6.0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward().then((v) async {
      NavigatorWidget.pushAndRemovePages(context: context, page: AuthRoot());
    });
  }

  void delay() async {
    await Future.delayed(Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topRight,
            end: AlignmentGeometry.bottomLeft,
            colors: [
              AppColors.accentBlue,
              AppColors.accentBlue,

              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _zoomOutAnimation,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Image.asset('assets/png/exchange.png'),
            ),
          ),
        ),
      ),
    );
  }
}
