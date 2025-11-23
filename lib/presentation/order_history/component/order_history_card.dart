import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/app.colors.dart';
import '../order_history.screen.dart';

class OrderHistoryCard extends StatelessWidget {
  final String orderDateTime;
  final String orderId;
  final String companyName;
  final String price;
  final VoidCallback onPreview;
  final VoidCallback onReOrder;

  const OrderHistoryCard({
    super.key,
    required this.orderDateTime,
    required this.orderId,
    required this.companyName,
    required this.price,
    required this.onPreview,
    required this.onReOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderDateTime,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontFamily: GoogleFonts.manrope().fontFamily,
                    ),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 8,
              //     vertical: 4,
              //   ),
              //   decoration: BoxDecoration(
              //     color: order.status == 'Delivered'
              //         ? Colors.green[50]
              //         : Colors.red[50],
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Text(
              //     order.status,
              //     style: Theme.of(context).textTheme.labelSmall?.copyWith(
              //           color: order.status == 'Delivered'
              //               ? Colors.green
              //               : Colors.red,
              //           fontFamily: GoogleFonts.manrope().fontFamily,
              //           fontWeight: FontWeight.w600,
              //         ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderId,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: Get.width*0.5,
                    child: Text(
                      companyName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontFamily: GoogleFonts.manrope().fontFamily,
                          ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Total Price",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'BDT $price',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: Get.width,
            child: ElevatedButton(
              onPressed: onPreview,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.light.buttonGradient1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Preview',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontFamily: GoogleFonts.manrope().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Row(
          //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     // Expanded(
          //     //   child: ElevatedButton(
          //     //     onPressed: onReOrder,
          //     //     style: ElevatedButton.styleFrom(
          //     //       backgroundColor: AppColors.light.buttonGradient1,
          //     //       shape: RoundedRectangleBorder(
          //     //         borderRadius: BorderRadius.circular(4),
          //     //       ),
          //     //     ),
          //     //     child: Text(
          //     //       'Re -order',
          //     //       style: Theme.of(context).textTheme.labelMedium?.copyWith(
          //     //             color: Colors.white,
          //     //             fontFamily: GoogleFonts.manrope().fontFamily,
          //     //             fontWeight: FontWeight.w600,
          //     //           ),
          //     //     ),
          //     //   ),
          //     // ),
          //     // const SizedBox(width: 12),
          //     ElevatedButton(
          //       onPressed: onPreview,
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: AppColors.light.buttonGradient1,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(4),
          //         ),
          //       ),
          //       child: Text(
          //         'Preview',
          //         style: Theme.of(context).textTheme.labelMedium?.copyWith(
          //           color: Colors.white,
          //               fontFamily: GoogleFonts.manrope().fontFamily,
          //               fontWeight: FontWeight.w600,
          //             ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
