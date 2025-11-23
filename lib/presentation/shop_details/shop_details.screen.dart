import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/navigation/routes.dart';
import '../../infrastructure/data/model/shop/shop_menu_model.dart';
import '../../infrastructure/theme/app.colors.dart';
import 'controllers/shop_details.controller.dart';

class ShopDetailsScreen extends GetView<ShopDetailsController> {
  const ShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 200.0,
            pinned: true,
            leading: IconButton(
              padding: const EdgeInsets.only(top: 16, left: 16),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black54),
              ),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    controller.shopImageUrl.value,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),

          // Shop Details Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Obx(() {
                          return Text(
                            controller.shopDetails.value?.data?.name ?? "",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.orange, size: 32),
                          const SizedBox(width: 4),
                          Text(
                            '4.5',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Obx(() {
                          return Text(
                            controller.shopDetails.value?.data?.name ?? "",
                            style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Delivery Info
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Immediate Delivery',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Menu Categories Tab Bar
                  Obx(() {
                    final sections =
                        controller.shopMenuDetails.value?.data?.sections ?? [];
                    final isMenuLoading = controller.isLoadingMenu.value;

                    if (isMenuLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (sections.isEmpty) {
                      return const Center(child: Text("No menu available"));
                    }

                    // Ensure TabController is initialized
                    if (controller.tabController == null ||
                        controller.tabController!.length != sections.length) {
                      controller.tabController?.dispose();
                      controller.tabController = TabController(
                        length: sections.length,
                        vsync: controller,
                      );
                      controller.tabController!.addListener(() {
                        controller.selectedCategoryIndex.value =
                            controller.tabController!.index;
                      });
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: TabBar(
                            controller: controller.tabController,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            padding: EdgeInsets.zero,
                            labelPadding: const EdgeInsets.only(right: 16),
                            indicatorPadding: EdgeInsets.zero,
                            indicator: const UnderlineTabIndicator(
                              borderSide: BorderSide(color: Colors.black),
                              insets: EdgeInsets.zero,
                            ),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey[700],
                            labelStyle: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            tabs: sections
                                .map((category) =>
                                Tab(text: category.name ?? ""))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: TabBarView(
                            controller: controller.tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: sections.map((category) {
                              final items = category.items ?? [];
                              if (items.isEmpty) {
                                return const Center(
                                  child: Text("No items available"),
                                );
                              }
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  return _buildMenuItemCard(item);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }),
                  // Obx(() {
                  //   if (controller.isLoadingMenu.value || controller.tabController == null) {
                  //     return const Center(child: CircularProgressIndicator());
                  //   }
                  //
                  //   final sections = controller.shopMenuDetails.value?.data?.sections ?? [];
                  //   if (sections.isEmpty) {
                  //     return const Center(child: Text("No menu available"));
                  //   }
                  //
                  //   return Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       // 🔹 TabBar
                  //       SizedBox(
                  //         height: 40,
                  //         child: TabBar(
                  //           controller: controller.tabController,
                  //           onTap: controller.selectCategory,
                  //           isScrollable: true,
                  //           indicator: const UnderlineTabIndicator(
                  //             borderSide: BorderSide(color: Colors.black),
                  //           ),
                  //           labelColor: Colors.black,
                  //           unselectedLabelColor: Colors.grey[700],
                  //           labelStyle: GoogleFonts.manrope(
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //           tabs: sections.map((category) => Tab(text: category.name)).toList(),
                  //         ),
                  //       ),
                  //
                  //       const SizedBox(height: 16),
                  //
                  //       // 🔹 TabBarView
                  //       SizedBox(
                  //         height: MediaQuery.of(context).size.height * 0.6,
                  //         child: TabBarView(
                  //           controller: controller.tabController,
                  //           physics: const NeverScrollableScrollPhysics(),
                  //           children: sections.map((category) {
                  //             final items = category.items ?? [];
                  //             if (items.isEmpty) {
                  //               return const Center(
                  //                 child: Text("No items available"),
                  //               );
                  //             }
                  //             return ListView.builder(
                  //               padding: EdgeInsets.zero,
                  //               itemCount: items.length,
                  //               itemBuilder: (context, index) {
                  //                 final item = items[index];
                  //                 return _buildMenuItemCard(item);
                  //               },
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ],
                  //   );
                  // }),

                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemCard(Items item) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.SHOP_MENU,
          arguments: {
            "shop_menu_id": item.id,
            "shop_menu_name": item.name,
            "shop_image": item.images?.first,
            "shop_description": item.description,
            "shop_price": item.price,
            "shop_id": controller.shopMenuDetails.value?.data?.shop,
            "shop_name": controller.shopMenuDetails.value?.data?.name,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Item Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: NetworkImage(item.images?.first ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? "",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description ?? "",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'BDT ${item.price?.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.light.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
