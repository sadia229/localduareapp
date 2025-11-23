import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/track_order.controller.dart';

class OrderInformationSections extends GetView<TrackOrderController> {
  const OrderInformationSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Text(
                    controller.formatOrderDate(
                        controller.trackOrders.value?.data?.first.orderDate ??
                            ""),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontFamily: GoogleFonts.manrope().fontFamily,
                        ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        controller.orderId.value.toString(),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                      );
                    }),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: Get.width * 0.5,
                      child: Obx(() {
                        return Text(
                          controller.trackOrders.value?.data?.first.shopId
                                  ?.name ??
                              "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Colors.black,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                              ),
                        );
                      }),
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
                      'BDT ${controller.trackOrders.value?.data?.first.grandTotal ?? ""}',
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
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.grey[600],
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Order Estimated time",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                        fontFamily: GoogleFonts.manrope().fontFamily,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "30mins",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                        fontFamily: GoogleFonts.manrope().fontFamily,
                      ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
