import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:text_form_field_validator/text_form_field_validator.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/app.assets.dart';
import '../../infrastructure/theme/app.colors.dart';
import '../shared/button/app.button.dart';
import '../shared/common/app.background.dart';
import '../shared/common/header_text.dart';
import 'controllers/send_otp.controller.dart';

class SendOtpScreen extends GetView<SendOtpController> {
  const SendOtpScreen({Key? key}) : super(key: key);

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
              HeaderText(text: "Authentication\nRequired"),
              SizedBox(height: 8.0),
              Text(
                "A one-time code has been sent to your number",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: 16.0),
              PinInputTextFormField(
                autoFocus: true,
                cursor: Cursor(
                    color: AppColors.light.borderColor3, width: 5, height: 8),
                controller: controller.otpController,
                validator: (value) => FormValidator.validate(
                  value,
                  required: true,
                  min: 6,
                  minMessage: "OTP must be 6 digits",
                ),
                // onChanged: (value) =>
                // value.length == 6
                //     ? controller.verifyOtp(value)
                //     : null,
                decoration: BoxLooseDecoration(
                  radius: Radius.circular(4.0),
                  gapSpace: 8.0,
                  bgColorBuilder: PinListenColorBuilder(
                    Colors.transparent,
                    Colors.transparent,
                    //const Color(0xffFAFAFA),
                    //const Color(0xffFAFAFA),
                  ),
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        color: Colors.black,
                      ),
                  errorTextStyle:
                      Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            color: Colors.red,
                          ),
                  strokeColorBuilder: PinListenColorBuilder(
                    AppColors.light.borderColor3,
                    AppColors.light.borderColor3,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              InkWell(
                onTap: null,
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn't gey the code yet? ",
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Resend',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Obx(() {
                if (controller.isOtpLoading) {
                  return AppLoadingButton();
                }
                return AppButton(
                  text: "Submit",
                  onTap: () => controller.verifyOtp(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
