import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/navigation/routes.dart';

import '../../infrastructure/theme/app.assets.dart';
import '../../infrastructure/theme/app.colors.dart';
import '../shared/button/app.button.dart';
import '../shared/common/app.background.dart';
import '../shared/common/header_text.dart';
import 'controllers/select_phone_number.controller.dart';

class SelectPhoneNumberScreen extends GetView<SelectPhoneNumberController> {
  const SelectPhoneNumberScreen({Key? key}) : super(key: key);

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
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
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
              ),
              SizedBox(height: 16.0),
              HeaderText(text: "Please Login"),
              SizedBox(height: 8.0),
              Text(
                "Find the best Delivery App  in your city and get it delivered to your place!",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: 16.0),
              Obx(() {
                controller.phoneNumberError.value;
                return TextField(
                  controller: controller.phoneNumberTextController,
                  onChanged: controller.validatePhoneNumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          BorderSide(color: AppColors.light.borderColor3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          BorderSide(color: AppColors.light.borderColor3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          BorderSide(color: AppColors.light.borderColor3),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          BorderSide(color: AppColors.light.borderColor3),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          BorderSide(color: AppColors.light.borderColor3),
                    ),
                    hintText: 'Enter your phone number',
                    hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          color: Colors.black,
                        ),
                  ),
                );
              }),
              Obx(() {
                return controller.phoneNumberError.value.isEmpty ||
                        controller.phoneNumberError.value == ''
                    ? SizedBox(height: 0.0)
                    : SizedBox(height: 8.0);
              }),
              Obx(() {
                return controller.phoneNumberError.value.isEmpty ||
                        controller.phoneNumberError.value == ''
                    ? SizedBox.shrink()
                    : Text(
                        controller.phoneNumberError.value,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  color: Colors.red,
                                ),
                      );
              }),
              SizedBox(height: 12.0),
              Obx(() {
                if(controller.isLoading){
                  return AppLoadingButton();
                }
                return AppButton(
                  text: "Log In",
                  onTap: () => controller.sendPhone(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
