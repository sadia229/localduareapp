import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../infrastructure/theme/app.colors.dart';
import '../controllers/shop_menu.controller.dart';

class ProductHeaderSection extends GetView<ShopMenuController> {
  const ProductHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  controller.menuName.value,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'BDT ${controller.menuPrice.value.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.light.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            controller.shopName.value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
