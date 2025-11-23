import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app.colors.dart';
import '../controllers/cart.controller.dart';

class DeliveryAddress extends GetView<CartController> {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    "Delivery Address",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Obx(() => Text(
                    "${controller.deliveryAddress.value?['street'] ?? ''}, ${controller.deliveryAddress.value?['area'] ?? ''},"
                        "${controller.deliveryAddress.value?['city'] ?? ''},${controller.deliveryAddress.value?['district'] ?? ''}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            Get.toNamed(Routes.ADD_ADDRESS, arguments: {
              'isFromCart': true,
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Add Address",
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
