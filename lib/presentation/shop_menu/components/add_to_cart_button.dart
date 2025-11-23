import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/navigation/routes.dart';
import 'package:localduareapp/presentation/shop_menu/components/select_quantity_section.dart';
import '../../../infrastructure/theme/app.assets.dart';
import '../../../infrastructure/theme/app.colors.dart';
import '../controllers/shop_menu.controller.dart';

class AddToCartButton extends GetView<ShopMenuController> {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectQuantitySection(),
        const SizedBox(height: 4),
        InkWell(
          borderRadius: BorderRadius.circular(4.0),
          onTap: () {
            controller.addToCart();
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
                  "Add To Cart",
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
      ],
    );
  }
}
