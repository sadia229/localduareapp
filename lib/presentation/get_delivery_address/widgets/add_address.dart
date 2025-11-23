import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../controllers/get_delivery_address.controller.dart';

class AddAddressButton extends GetView<GetDeliveryAddressController> {
  const AddAddressButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DottedBorder(
          // color: Colors.blue.shade800,
          // strokeWidth: 1,
          // dashPattern: [6, 3],
          // borderType: BorderType.RRect,
          // radius: const Radius.circular(8),
          child: InkWell(
            // onTap: () => Get.toNamed(Routes.ADD_ADDRESS, arguments: {
            //   'isFromCart': false,
            // }),
            onTap: () => Get.toNamed(Routes.PROFILE_ADD_ADDRESS),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 100,
              color: Colors.white,
              alignment: Alignment.center,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 24, color: Colors.blue.shade800),
                    SizedBox(width: 12.0),
                    Text(
                      "Add Address",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
