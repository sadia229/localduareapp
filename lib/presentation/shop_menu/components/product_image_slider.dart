import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/shop_menu.controller.dart';

class ProductImageSlider extends GetView<ShopMenuController> {
  const ProductImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: double.infinity,
      child: Image(
        image: NetworkImage(controller.menuImageUrl.value),
        fit: BoxFit.cover,
      ),
    );
    // return Stack(
    //   children: [
    //     // Main Image
    //     SizedBox(
    //       height: 270,
    //       width: double.infinity,
    //       child: PageView.builder(
    //         itemCount: controller.itemImages.length,
    //         onPageChanged: (index) => controller.currentImageIndex.value = index,
    //         itemBuilder: (context, index) {
    //           return Image.network(
    //             controller.itemImages[index],
    //             fit: BoxFit.cover,
    //           );
    //         },
    //       ),
    //     ),
    //
    //     Positioned(
    //       left: 16,
    //       top: 20,
    //       bottom: 0,
    //       child: Obx(() => IconButton(
    //         icon: Container(
    //           padding: const EdgeInsets.all(8),
    //           decoration: BoxDecoration(
    //             color: controller.currentImageIndex.value > 0
    //                 ? AppColors.light.primaryColor
    //                 : Colors.white.withOpacity(0.5),
    //             shape: BoxShape.circle,
    //           ),
    //           child: Icon(
    //             Icons.arrow_back_ios,
    //             size: 20,
    //             color: controller.currentImageIndex.value > 0
    //                 ? Colors.white
    //                 : Colors.grey,
    //           ),
    //         ),
    //         onPressed: controller.currentImageIndex.value > 0
    //             ? controller.goToPreviousImage
    //             : null,
    //       )),
    //     ),
    //
    //     // Next Button (Always visible but disabled when at last image)
    //     Positioned(
    //       right: 16,
    //       top: 20,
    //       bottom: 0,
    //       child: Obx(() => IconButton(
    //         icon: Container(
    //           padding: const EdgeInsets.all(8),
    //           decoration: BoxDecoration(
    //             color: controller.currentImageIndex.value < controller.itemImages.length - 1
    //                 ? AppColors.light.primaryColor
    //                 : Colors.white.withOpacity(0.5),
    //             shape: BoxShape.circle,
    //           ),
    //           child: Icon(
    //             Icons.arrow_forward_ios,
    //             size: 20,
    //             color: controller.currentImageIndex.value < controller.itemImages.length - 1
    //                 ? Colors.white
    //                 : Colors.grey,
    //           ),
    //         ),
    //         onPressed: controller.currentImageIndex.value < controller.itemImages.length - 1
    //             ? controller.goToNextImage
    //             : null,
    //       )),
    //     ),
    //
    //     // Image Indicator
    //     Positioned(
    //       top: Get.height*0.2,
    //       left: 0,
    //       right: 0,
    //       bottom: 0,
    //       child: Obx(() => Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: List.generate(controller.itemImages.length, (index) {
    //           return Container(
    //             width: controller.currentImageIndex.value == index?40:8,
    //             height: 8,
    //             margin: const EdgeInsets.symmetric(horizontal: 4),
    //             decoration: BoxDecoration(
    //               borderRadius: controller.currentImageIndex.value == index?BorderRadius.circular(12):BorderRadius.circular(4),
    //               color: controller.currentImageIndex.value == index
    //                   ? AppColors.light.primaryColor
    //                   : Colors.white.withOpacity(0.5),
    //             ),
    //           );
    //         }),
    //       )),
    //     ),
    //   ],
    // );
  }
}
