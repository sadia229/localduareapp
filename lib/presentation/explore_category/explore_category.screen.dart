import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/navigation/routes.dart';

import '../../infrastructure/theme/app.assets.dart';
import '../shared/button/app.button.dart';
import '../shared/common/app.background.dart';
import 'controllers/explore_category.controller.dart';

class ExploreCategoryScreen extends GetView<ExploreCategoryController> {
  const ExploreCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: Get.height * 0.08)),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
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
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "Explore a\nCategory Now",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 8.0)),
              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "Please select A Category that\nyou want to explore ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          color: Colors.black,
                        ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Image.asset(
                            "assets/images/restaurent.png",
                            height: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Restaurants",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 24),
        child: AppButton(text: "Next", onTap: () {
          debugPrint("tap explore category");
          Get.toNamed(Routes.BOTTOM_NAVBAR);
        }),
      ),
    );
  }
}
