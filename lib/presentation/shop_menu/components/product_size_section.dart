import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/shop_menu.controller.dart';

class ProductSizeSection extends GetView<ShopMenuController> {
  const ProductSizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       'Select Size',
    //       style: GoogleFonts.poppins(
    //         fontSize: 16,
    //         fontWeight: FontWeight.w500,
    //         color: Colors.black87,
    //       ),
    //     ),
    //     const SizedBox(height: 8),
    //     Obx(() {
    //       final selectedSize = controller.sizes.firstWhereOrNull(
    //         (size) => size.isSelected,
    //       );
    //
    //       return Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 16),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(12),
    //           border: Border.all(
    //             color: Colors.grey[300]!,
    //             width: 1.2,
    //           ),
    //         ),
    //         child: DropdownButtonHideUnderline(
    //           child: DropdownButton<MenuSize>(
    //             value: selectedSize,
    //             isExpanded: true,
    //             icon: const Icon(Icons.keyboard_arrow_down_rounded),
    //             iconSize: 24,
    //             elevation: 16,
    //             style: GoogleFonts.poppins(
    //               fontSize: 14,
    //               color: Colors.black87,
    //             ),
    //             dropdownColor: Colors.white,
    //             borderRadius: BorderRadius.circular(12),
    //             onChanged: (MenuSize? newValue) {
    //               if (newValue != null) {
    //                 controller.selectSize(newValue.id);
    //               }
    //             },
    //             items: controller.sizes
    //                 .map<DropdownMenuItem<MenuSize>>((MenuSize size) {
    //               return DropdownMenuItem<MenuSize>(
    //                 value: size,
    //                 child: Text(
    //                   size.name,
    //                   style: GoogleFonts.poppins(
    //                     fontSize: 14,
    //                     fontWeight: size.isSelected
    //                         ? FontWeight.w600
    //                         : FontWeight.normal,
    //                   ),
    //                 ),
    //               );
    //             }).toList(),
    //           ),
    //         ),
    //       );
    //     }),
    //   ],
    // );
  }
}
