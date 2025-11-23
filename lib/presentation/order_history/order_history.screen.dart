import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/navigation/routes.dart';
import 'package:localduareapp/presentation/shared/common/app.background.dart';

import 'component/order_history_card.dart';
import 'controllers/order_history.controller.dart';

final List<String> categoryItems = [
  'Restaurants',
  'Food & Beverage',
  'Grocery',
  'Electronics',
  'Fashion'
];

class OrderHistoryScreen extends GetView<OrderHistoryController> {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: Get.height * 0.06)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  color: Colors.black,
                                ),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: categoryItems.first,
                              isExpanded: false,
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: categoryItems.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontFamily:
                                              GoogleFonts.manrope().fontFamily,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  // Handle category change
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Image.asset(
                          "assets/images/Bag 4.png",
                          height: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  "Order",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }

              final orders = controller.orderHistoryList.value?.data ?? [];

              if (orders.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Text(
                        "No Order History",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final order =
                        controller.orderHistoryList.value?.data[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: OrderHistoryCard(
                        orderId: order?.orderId ?? "",
                        companyName: order?.shopId.name ?? "",
                        orderDateTime: controller
                            .formatOrderDate(order?.orderDate.toString() ?? ""),
                        price: order?.subtotal.toString() ?? "",
                        onPreview: () {
                          Get.toNamed(
                            Routes.ORDER_HISTORY_DETAILS,
                            arguments: {
                              "orderId": order?.orderId,
                              "orderDate": order?.orderDate.toString(),
                              "shopName": order?.shopId.name ?? "",
                              "subtotal": order?.subtotal,
                              "deliveryCharge": order?.deliveryCharge,
                              "total": order?.grandTotal,
                              "orderItems": order?.items,
                              "payment_method": order?.paymentMethod,
                              "payment_status": order?.paymentStatus,
                              "status": order?.status,
                            },
                          );
                        },
                        onReOrder: () {
                          Get.toNamed(Routes.CART);
                        },
                      ),
                    );
                  },
                  childCount:
                      controller.orderHistoryList.value?.data.length ?? 0,
                ),
              );
            }),
            SliverToBoxAdapter(child: const SizedBox(height: 160)),
          ],
        ),
      ),
    );
  }
}
