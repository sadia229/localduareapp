import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../infrastructure/theme/app.colors.dart';
import '../shared/common/app.background.dart';
import 'controllers/get_delivery_address.controller.dart';
import 'widgets/add_address.dart';
import 'widgets/address_card.dart';

class GetDeliveryAddressScreen extends GetView<GetDeliveryAddressController> {
  const GetDeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Delivery Address",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontFamily: GoogleFonts.manrope().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AppBackground(
        child: CustomScrollView(
          slivers: [
            // SliverAppBar(
            //   pinned: true,
            //   floating: false,
            //   expandedHeight: Get.height * 0.12,
            //   automaticallyImplyLeading: false,
            //   backgroundColor: Colors.white,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: Container(
            //       decoration: const BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(20.0),
            //           bottomRight: Radius.circular(20.0),
            //         ),
            //       ),
            //       alignment: Alignment.center,
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           InkWell(
            //             borderRadius: BorderRadius.circular(12.0),
            //             onTap: () {
            //               Get.back();
            //             },
            //             child: Container(
            //               margin: const EdgeInsets.symmetric(horizontal: 16.0),
            //               padding: const EdgeInsets.all(16.0),
            //               decoration: BoxDecoration(
            //                 color: AppColors.light.buttonBackground,
            //                 borderRadius: BorderRadius.circular(12.0),
            //               ),
            //               child: Image.asset(
            //                 "assets/images/arrow_left_alt.png",
            //                 height: 24.0,
            //               ),
            //             ),
            //           ),
            //           Text(
            //             "Delivery Address",
            //             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            //               fontFamily: GoogleFonts.manrope().fontFamily,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            AddAddressButton(),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: AddressCard(),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }
}




