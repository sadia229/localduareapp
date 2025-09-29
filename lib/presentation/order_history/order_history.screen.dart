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
      body: SafeArea(
        child: AppBackground(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
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
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                    color: Colors.black,
                                  ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: categoryItems.first,
                                isExpanded: false,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                items: categoryItems.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontFamily: GoogleFonts.manrope()
                                                .fontFamily,
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final isLast = index == 9;
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: isLast ? 100.0 : 16.0,
                          left: 16.0,
                          right: 16.0),
                      child: OrderHistoryCard(
                        orderId: '#12344',
                        companyName: 'Pizza Hut',
                        orderDateTime: 'Yesterday, 7:45 PM',
                        price: "24.50",
                        onPreview: () {
                          Get.toNamed(
                            Routes.ORDER_HISTORY_PREVIEW,
                            arguments: {
                              "orderId": 12344,
                            },
                          );
                        },
                        onReOrder: () {
                          Get.toNamed(Routes.CART);
                        },
                      ),
                    );
                  },
                  childCount: 10,
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
