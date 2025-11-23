import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/navigation/routes.dart';
import 'package:localduareapp/presentation/shared/common/app.background.dart';
import '../../infrastructure/theme/app.colors.dart';
import '../cart/components/order_summary_item_card.dart';
import 'controllers/order_history_details.controller.dart';

class OrderHistoryDetailsScreen extends GetView<OrderHistoryDetailsController> {
  const OrderHistoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          'Order Id #${controller.orderId.value}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: GoogleFonts.manrope().fontFamily,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: AppBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.light.lightGray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Text(
                                  controller.formatOrderDate(
                                      controller.orderDate.value),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.grey[600],
                                        fontFamily:
                                            GoogleFonts.manrope().fontFamily,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontFamily: GoogleFonts.manrope()
                                                .fontFamily,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    );
                                  }),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: Get.width * 0.5,
                                    child: Obx(() {
                                      return Text(
                                        controller.shopName.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontFamily: GoogleFonts.manrope()
                                                  .fontFamily,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.black,
                                          fontFamily:
                                              GoogleFonts.manrope().fontFamily,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'BDT ${controller.subtotal.value.toString()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontFamily:
                                              GoogleFonts.manrope().fontFamily,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _CartItems(),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              Obx(() {
                return OrderSummaryItemCard(
                  label: "Sub-Total",
                  amount: controller.subtotal.value.toDouble(),
                );
              }),
              Obx(() {
                return OrderSummaryItemCard(
                  label: "Delivery Charge",
                  amount: controller.deliveryCharge.value.toDouble(),
                );
              }),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  Obx(() {
                    return Text(
                      "BDT ${controller.total.value}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.light.buttonGradient2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.TRACK_ORDER,
                        arguments: {
                          "orderId": controller.orderId.value,
                          "payment_method": controller.paymentMethod.value,
                          "payment_status": controller.paymentStatus.value,
                          "status": controller.status.value,
                        });
                  },
                  child: Text(
                    "Track Order",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: AppColors.light.buttonGradient2,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDiscount ? Colors.green : null,
              fontWeight: isTotal ? FontWeight.bold : null,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : null,
              fontWeight: isTotal ? FontWeight.bold : null,
              color: isDiscount ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItems extends GetView<OrderHistoryDetailsController> {
  const _CartItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.light.lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: controller.orderItems.length ?? 0,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1}.",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        controller.orderItems[index].name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Qty",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${controller.orderItems[index].quantity}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'BDT ${controller.orderItems[index].totalPrice}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
