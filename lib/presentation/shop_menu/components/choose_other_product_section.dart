import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/shop_menu.controller.dart';

class ChooseOtherProductSection extends GetView<ShopMenuController> {
  const ChooseOtherProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       'Choose soft drinks',
    //       style: GoogleFonts.poppins(
    //         fontSize: 18,
    //         fontWeight: FontWeight.w600,
    //       ),
    //     ),
    //     const SizedBox(height: 12),
    //     Obx(() => Column(
    //           children: controller.options
    //               .map((option) => Padding(
    //                     padding: const EdgeInsets.only(bottom: 8.0),
    //                     child: InkWell(
    //                       onTap: () => controller.toggleOption(option.id),
    //                       child: Row(
    //                         children: [
    //                           Container(
    //                             width: 20,
    //                             height: 20,
    //                             decoration: BoxDecoration(
    //                               shape: BoxShape.circle,
    //                               border: Border.all(
    //                                 color: option.isSelected
    //                                     ? Theme.of(Get.context!).primaryColor
    //                                     : Colors.grey[400]!,
    //                                 width: 2,
    //                               ),
    //                             ),
    //                             child: option.isSelected
    //                                 ? Center(
    //                                     child: Container(
    //                                       width: 12,
    //                                       height: 12,
    //                                       decoration: BoxDecoration(
    //                                         color: Theme.of(Get.context!)
    //                                             .primaryColor,
    //                                         shape: BoxShape.circle,
    //                                       ),
    //                                     ),
    //                                   )
    //                                 : null,
    //                           ),
    //                           const SizedBox(width: 12),
    //                           Expanded(
    //                             child: Text(
    //                               option.name,
    //                               style: GoogleFonts.poppins(
    //                                 fontSize: 14,
    //                                 color: Colors.black87,
    //                               ),
    //                             ),
    //                           ),
    //                           Text(
    //                             '+ BDT ${option.price.toStringAsFixed(2)}',
    //                             style: GoogleFonts.poppins(
    //                               fontSize: 14,
    //                               color: Colors.black87,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ))
    //               .toList(),
    //         )),
    //   ],
    // );
  }
}
