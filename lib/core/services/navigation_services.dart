import 'package:flutter/material.dart';

class NavigatorWidget {
  static void push({required BuildContext context, required Widget page}) {
    Navigator.push(context, _buildAnimatedRoute(page));
  }

  static void pushAndRemovePages({
    required BuildContext context,
    required Widget page,
  }) {
    Navigator.pushReplacement(context, _buildAnimatedRoute(page));
  }

  static Route _buildAnimatedRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
