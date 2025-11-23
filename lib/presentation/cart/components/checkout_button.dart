import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app.assets.dart';
import '../../../infrastructure/theme/app.colors.dart';
import '../controllers/cart.controller.dart';

class CheckoutButton extends GetView<CartController> {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4.0),
      onTap: () {
        Get.toNamed(Routes.CHECKOUT, arguments: {
          'sub_total': controller.subtotal.value,
          'delivery_charge': controller.deliveryCharge.value,
          'total': controller.total.value,
        });
      },
      child: Container(
        width: double.infinity,
        height: 56.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0).copyWith(
          bottom: Get.height * 0.07,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: LinearGradient(
            colors: [
              AppColors.light.buttonGradient1,
              AppColors.light.buttonGradient2,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Check Out",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            Image.asset(
              AppAssets.light.icons.nextButton,
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
