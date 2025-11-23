import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/cart.controller.dart';

class RiderTipsSection extends GetView<CartController> {
  const RiderTipsSection({super.key});

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
          Text(
            "Pay Tips For Rider",
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller.customTipController.value,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Add Amount",
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey[500],
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              suffixText: "BDT",
              suffixStyle: GoogleFonts.poppins(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                //controller.selectCustomTip(double.tryParse(value) ?? 0);
              }
            },
          ),
        ],
      ),
    );
  }
}
