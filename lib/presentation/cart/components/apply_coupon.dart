import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/theme/app.colors.dart';

import '../controllers/cart.controller.dart';
import 'order_summary_item_card.dart';

class ApplyCoupon extends GetView<CartController> {
  const ApplyCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     Expanded(
          //       child: TextField(
          //         controller: controller.couponController,
          //         decoration: InputDecoration(
          //           hintText: "Add Coupon",
          //           hintStyle: GoogleFonts.poppins(
          //             color: Colors.grey[500],
          //             fontSize: 14,
          //           ),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(4),
          //             borderSide: BorderSide(color: Colors.grey[300]!),
          //           ),
          //           enabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(4),
          //             borderSide: BorderSide(color: Colors.grey[300]!),
          //           ),
          //           contentPadding: const EdgeInsets.symmetric(
          //             horizontal: 16,
          //             vertical: 12,
          //           ),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     ElevatedButton(
          //       onPressed: controller.applyCoupon,
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: AppColors.light.buttonGradient2,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          //       ),
          //       child: Text(
          //         "Apply",
          //         style: GoogleFonts.manrope(
          //           color: Colors.white,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 16),
          Obx(() {
            return OrderSummaryItemCard(
              label: "Sub-Total",
              amount: controller.subtotal.value,
            );
          }),
          Obx(() {
            return OrderSummaryItemCard(
              label: "Delivery Charge",
              amount: controller.deliveryCharge.value,
            );
          }),
          // OrderSummaryItemCard(
          //   label: "Discount",
          //   amount: -controller.discount,
          // ),
          // OrderSummaryItemCard(
          //   label: "Rider Tips",
          //   amount: controller.tipAmount.value,
          // ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Obx(
                    () =>
                    Text(
                      "BDT ${controller.total.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
