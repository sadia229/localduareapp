import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/presentation/shared/common/app.background.dart';

import '../../infrastructure/theme/app.colors.dart';
import 'controllers/order_history_preview.controller.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String restaurantName;
  final int quantity;
  final String price;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.restaurantName,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.only(right: 12.0, top: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColors.light.buttonBackground,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  restaurantName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                      ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'BDT $price',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Qty ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
              ),
              Text(
                '2',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderHistoryPreviewScreen extends GetView<OrderHistoryPreviewController> {
  const OrderHistoryPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: Get.height * 0.12,
                margin: const EdgeInsets.only(top: 24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.light.buttonBackground,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Image.asset(
                          "assets/images/arrow_left_alt.png",
                          height: 24.0,
                        ),
                      ),
                    ),
                    Text(
                      "Order Id  #${controller.orderId.value.toString()}",
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            // Order Info Card
            SliverToBoxAdapter(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order #${controller.orderId.value.toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Colors.grey[600],
                                fontFamily: GoogleFonts.manrope().fontFamily,
                              ),
                        ),
                        Text(
                          "29 Jan, 12:30",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Colors.grey[600],
                                fontFamily: GoogleFonts.manrope().fontFamily,
                              ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          imageUrl:
                              "https://www.nhlbi.nih.gov/sites/default/files/styles/16x9_crop/public/2025-03/Ultraprocessed%20foods%20display%202%20framed%20-%20shutterstock_2137640529_r.jpg?h=ab94ba44&itok=yrOIN-8T",
                          name: "product name",
                          restaurantName: "restaurent name",
                          quantity: 2,
                          price: "200",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 24.0)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.light.buttonGradient1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Re -order',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 40,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.light.buttonGradient1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Preview',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
