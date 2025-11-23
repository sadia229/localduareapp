import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localduareapp/presentation/shared/common/app.background.dart';
import 'components/apply_coupon.dart';
import 'components/cart_app_bar.dart';
import 'components/cart_items.dart';
import 'components/checkout_button.dart';
import 'components/delivery_address.dart';
import 'components/rider_tips_section.dart';
import 'controllers/cart.controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            CartAppBar(),
            Expanded(
              child: RefreshIndicator(
                color: Colors.green,
                onRefresh: () async {
                  await controller.loadDeliveryAddress();
                  await controller.getDeliveryCharge();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16).copyWith(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      CartItems(),
                      const SizedBox(height: 8),
                      Obx(() {
                        if (controller.cartItems.isEmpty) {
                          return SizedBox();
                        }
                        return DeliveryAddress();
                      }),
                      const SizedBox(height: 8),
                      // RiderTipsSection(),
                      // const SizedBox(height: 8),
                      Obx(() {
                        if (controller.cartItems.isEmpty) {
                          return SizedBox();
                        }
                        return ApplyCoupon();
                      }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CheckoutButton(),
    );
  }
}
