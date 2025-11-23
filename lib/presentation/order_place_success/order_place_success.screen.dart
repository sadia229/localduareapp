import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/app.assets.dart';
import '../../infrastructure/theme/app.colors.dart';
import '../bottom_navbar/controllers/bottom_navbar.controller.dart';
import 'controllers/order_place_success.controller.dart';

class OrderPlaceSuccessScreen extends GetView<OrderPlaceSuccessController> {
  const OrderPlaceSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Success",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: GoogleFonts.manrope().fontFamily,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/order-success-image.png',
          height: 260,
        ),
      ),
      bottomNavigationBar: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () {
          Get.offAllNamed(Routes.BOTTOM_NAVBAR);
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
                "Track your Order",
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
      ),
    );
  }
}
