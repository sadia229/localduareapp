import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/app.colors.dart';
import '../controllers/checkout.controller.dart';

class PaymentMethods extends GetView<CheckoutController> {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12,left: 16,right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Obx(
        () => Column(
          children: [
            Row(
              children: [
                Icon(Icons.payment_sharp, color: Colors.grey[500], size: 18),
                const SizedBox(width: 8),
                Text(
                  "Payment method ",
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              children: controller.paymentMethods.map((method) {
                final isSelected =
                    controller.selectedPaymentMethod.value?.id == method.id;
                return Theme(
                  data: Theme.of(Get.context!).copyWith(
                    visualDensity: VisualDensity.comfortable,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: RadioListTile<String>(
                      value: method.id,
                      groupValue: controller.selectedPaymentMethod.value?.id,
                      onChanged: (_) => controller.selectPaymentMethod(method),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            method.name,
                            style: GoogleFonts.manrope(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (method.icon?.isNotEmpty ?? false)
                            Image.asset(
                              method.icon ?? '',
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.light.primaryColor,
                      contentPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: isSelected
                          ? AppColors.light.primaryColor.withOpacity(0.05)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
