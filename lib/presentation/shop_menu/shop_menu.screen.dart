import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../infrastructure/theme/app.assets.dart';
import '../../infrastructure/theme/app.colors.dart';
import 'components/add_to_cart_button.dart';
import 'components/choose_other_product_section.dart';
import 'components/product_description.dart';
import 'components/product_header_section.dart';
import 'components/product_image_slider.dart';
import 'components/product_size_section.dart';
import 'components/select_quantity_section.dart';
import 'controllers/shop_menu.controller.dart';

class ShopMenuScreen extends GetView<ShopMenuController> {
  const ShopMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 250,
            backgroundColor: AppColors.light.background,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ProductImageSlider(),
                  _buildAppBar(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0).copyWith(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  ProductHeaderSection(),
                  // const SizedBox(height: 16),
                  // ProductSizeSection(),
                  const SizedBox(height: 24),
                  ProductDescription(),
                  const SizedBox(height: 24),
                  // ChooseOtherProductSection(),
                  // const SizedBox(height: 12),
                  // SelectQuantitySection(),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AddToCartButton(),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: 40,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                child: const Icon(Icons.arrow_back, color: Colors.black54),
                onTap: () => Get.back(),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //     color: Colors.white.withOpacity(0.85),
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Obx(
            //     () => InkWell(
            //       child: Icon(
            //         controller.isFavorite.value
            //             ? Icons.favorite
            //             : Icons.favorite_border,
            //         color: controller.isFavorite.value
            //             ? Colors.red
            //             : Colors.black54,
            //       ),
            //       onTap: controller.toggleFavorite,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
