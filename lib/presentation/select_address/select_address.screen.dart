import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/navigation/routes.dart';
import 'package:localduareapp/infrastructure/theme/app.colors.dart';
import 'package:localduareapp/presentation/shared/button/app.button.dart';
import 'package:localduareapp/presentation/shared/common/app.background.dart';
import 'package:localduareapp/presentation/shared/common/header_text.dart';

import '../../infrastructure/theme/app.assets.dart';
import 'controllers/select_address.controller.dart';

class SelectAddressScreen extends GetView<SelectAddressController> {
  const SelectAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.08),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
                child: Image.asset(
                  AppAssets.light.icons.backButton,
                  height: 24.0,
                ),
              ),
              SizedBox(height: 16.0),
              HeaderText(text: "Please Select\nyour Area"),
              SizedBox(height: 8.0),
              Text(
                "Select the area where you are right now",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: AppColors.light.borderColor3),
                ),
                child: Obx(() {
                  return DropdownButton<String>(
                    isExpanded: true,
                    value: controller.selectedArea.value,
                    onChanged: (String? newValue) {
                      controller.selectedArea.value = newValue!;
                    },
                    underline: const SizedBox(),
                    items: <String>['Area 1', 'Area 2', 'Area 3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
              SizedBox(height: 12.0),
              AppButton(text: "Submit", onTap: () {Get.toNamed(Routes.SELECT_PHONE_NUMBER);}),
            ],
          ),
        ),
      ),
    );
  }
}
