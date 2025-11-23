import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/app.colors.dart';

class CheckoutAppBar extends StatelessWidget {
  const CheckoutAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.12,
      padding: const EdgeInsets.only(top: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12.0),
            onTap: () {
              Get.back();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.light.buttonBackground,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Image.asset(
                "assets/images/arrow_left_alt.png",
                height: 24.0,
              ),
            ),
          ),
          Text(
            "Check out",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: GoogleFonts.manrope().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
