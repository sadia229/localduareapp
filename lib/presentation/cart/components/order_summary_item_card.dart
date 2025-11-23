import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSummaryItemCard extends StatelessWidget {
  final String label;
  final num amount;

  const OrderSummaryItemCard({
    super.key,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14,
            ),
          ),
          Text(
            "BDT ${amount.toStringAsFixed(2)}",
            style: GoogleFonts.poppins(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
