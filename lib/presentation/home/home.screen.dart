import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/presentation/home/widgets/restaurant_card.dart';
import 'package:localduareapp/presentation/home/widgets/search_component.dart';
import 'package:localduareapp/presentation/shared/common/app.background.dart';
import 'package:localduareapp/presentation/shared/common/app.sizedbox.dart';
import 'package:localduareapp/presentation/shared/shimmer/restaurant_shimmer.dart';

import '../../infrastructure/navigation/routes.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackground(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SearchComponent(),
              SliverToBoxAdapter(
                child: Image.asset(
                  "assets/images/special-offer.png",
                  width: double.infinity,
                  height: 150,
                ),
              ),
              SliverSizedBox(height: 16.0),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  child: Text(
                    "All Restaurants",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                      fontFamily: GoogleFonts
                          .manrope()
                          .fontFamily,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Obx(() {
                if(controller.isLoading){
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return RestaurantShimmer();
                      },
                      childCount: 3,
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return RestaurantCard(
                        name: controller.shopList?.data?[index].name ?? "",
                        location: controller.shopList?.data?[index].franchise?.area?.name ?? "",
                        imageUrl: controller.shopList?.data?[index].images?.banner ?? "",
                      );
                    },
                    childCount: 10,
                  ),
                );
              }),
              SliverSizedBox(height: Get.height*0.12),
            ],
          ),
        ),
      ),
    );
  }
}
