
import 'package:currency_rate_calculator/core/configs/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    required this.buttonText,
    this.onTap,
    this.color,
    this.svgImage,
  });

  final String buttonText;
  final void Function()? onTap;
  final Color? color;
  final String? svgImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color ?? AppColors.accentBlue,
        ),
        child: Center(
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Text(
                buttonText,
                style:TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.25,
    color: Colors.white,
  ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
