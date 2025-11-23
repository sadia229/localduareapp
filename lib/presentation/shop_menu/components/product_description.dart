import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/shop_menu.controller.dart';

class ProductDescription extends GetView<ShopMenuController> {
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Text(
            controller.menuDescription.value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
