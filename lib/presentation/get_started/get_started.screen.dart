import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/navigation/routes.dart';
import 'package:localduareapp/infrastructure/theme/app.assets.dart';

import '../../infrastructure/theme/app.colors.dart';
import '../shared/common/app.background.dart';
import '../shared/common/header_text.dart';
import 'controllers/get_started.controller.dart';

class GetStartedScreen extends GetView<GetStartedController> {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.12),
                Center(
                  child: Image.asset(
                    "assets/logo/logo.png",
                    height: 50.0,
                  ),
                ),
                SizedBox(height: Get.height * 0.1),
                Center(
                  child: Image.asset(
                    "assets/images/get-started.png",
                    height: Get.height * 0.28,
                  ),
                ),
                SizedBox(height: Get.height * 0.09),
                HeaderText(text: "The Fast\nDelivery App"),
                SizedBox(height: 8.0),
                Text(
                  "Find the best Delivery App  in your city and get it delivered to your place!",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        color: Colors.black,
                      ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () => controller.checkToken(),
        child: Container(
          width: double.infinity,
          height: 56.0,
          margin: EdgeInsets.symmetric(horizontal: 16.0).copyWith(
            bottom: Get.height * 0.07,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            gradient: LinearGradient(
              colors: [
                AppColors.light.buttonGradient1,
                AppColors.light.buttonGradient2,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Get Started",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              Image.asset(
                AppAssets.light.icons.nextButton,
                height: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
