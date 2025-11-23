import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/theme/app.colors.dart';
import 'package:localduareapp/presentation/shared/common/app.background.dart';
import '../cart/components/order_summary_item_card.dart';
import '../shared/button/app.button.dart';
import 'components/checkout_appbar.dart';
import 'components/payment_methods.dart';
import 'components/special_instructions.dart';
import 'controllers/checkout.controller.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckoutAppBar(),
              PaymentMethods(),
              SpecialInstructions(),
              SizedBox(height: Get.height * 0.06),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Obx(() {
                      return OrderSummaryItemCard(
                        label: "Sub-Total",
                        amount: controller.subTotal.value,
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
                    //   amount: 20.00,
                    // ),
                    // OrderSummaryItemCard(
                    //   label: "Rider Tips",
                    //   amount: 20.00,
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
                        Obx(() {
                          return Text(
                            "BDT ${controller.total.value.toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        if(controller.isOrderPlaceLoading.value){
          return AppLoadingButton();
        }
        return _buildCheckoutButton();
      }),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: Get.height * 0.06),
      child: ElevatedButton(
        onPressed: controller.placeOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.light.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Place Order',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
