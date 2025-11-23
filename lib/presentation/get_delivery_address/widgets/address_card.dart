import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/navigation/routes.dart';

import '../../../infrastructure/theme/app.colors.dart';
import '../controllers/get_delivery_address.controller.dart';

class AddressCard extends GetView<GetDeliveryAddressController> {
  const AddressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final addresses = controller.savedAddresses;
      final selectedIndex = controller.selectedAddressIndex.value;

      if (addresses.isEmpty) {
        return const Center(child: Text('No saved addresses.'));
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                RadioListTile<int>(
                  value: index,
                  groupValue: selectedIndex,
                  visualDensity: VisualDensity.compact,
                  // 👈 reduces vertical padding
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    if (value != null) controller.saveSelectedAddress(value);
                  },
                  title: Text(
                    '${address['street'] ?? ''}, ${address['area'] ?? ''}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          color: Colors.black,
                        ),
                  ),
                  subtitle: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${address['city'] ?? ''}, ${address['district'] ?? ''}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              color: Colors.black54,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade800,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          '${address['label'] ?? 'Home'}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ],
                  ),
                  secondary: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Delete
                      InkWell(
                        onTap: () =>
                            controller.removeFromListImmediately(index),
                        child: Text(
                          "Delete",
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.blue.shade800,
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Edit
                      InkWell(
                        onTap: () {
                          final address = controller.savedAddresses[index];
                          Get.toNamed(
                            Routes.PROFILE_ADD_ADDRESS,
                            arguments: {
                              "address": address,
                              "index": index,
                            },
                          );
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            "Edit",
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  color: Colors.blue.shade800,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });

    return Obx(() {
      if (controller.savedAddresses.isEmpty) {
        return const Center(child: Text('No saved addresses found.'));
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        itemCount: controller.savedAddresses.length,
        itemBuilder: (context, index) {
          final address = controller.savedAddresses[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 24.0),
            padding: EdgeInsets.only(top: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              '${address['street'] ?? ''}, ${address['area'] ?? ''}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.removeFromListImmediately(index);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(Icons.delete,
                                      size: 24, color: Colors.blue.shade800),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  final address =
                                      controller.savedAddresses[index];
                                  Get.toNamed(
                                    Routes.PROFILE_ADD_ADDRESS,
                                    arguments: {
                                      "address": address,
                                      "index": index,
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    "Edit",
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              GoogleFonts.manrope().fontFamily,
                                          color: Colors.blue.shade800,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '${address['city'] ?? ''}, ${address['district'] ?? ''}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              color: Colors.black,
                            ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
                Positioned(
                  right: 0.0,
                  left: 16.0,
                  top: -25,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '${address['label'] ?? 'Home'}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
