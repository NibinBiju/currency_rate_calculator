import 'package:currency_rate_calculator/core/services/navigation_services.dart';
import 'package:currency_rate_calculator/data/source/auth_source.dart';
import 'package:currency_rate_calculator/get_service_locator.dart';
import 'package:currency_rate_calculator/presentation/features/auth/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class DialogService {
  static Future<bool?> showLogoutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                getIt<AuthSource>().logout();
                NavigatorWidget.pushAndRemovePages(
                  context: context,
                  page: SignInPage(),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
