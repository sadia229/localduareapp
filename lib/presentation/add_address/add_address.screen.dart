import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../infrastructure/theme/app.colors.dart';
import 'controllers/add_address.controller.dart';

class AddAddressScreen extends GetView<AddAddressController> {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    return Scaffold(
      backgroundColor: AppColors.light.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add Address",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: GoogleFonts.manrope().fontFamily,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (ctrl.currentLatLng.value == null) {
          return const Center(child: Text('Unable to get location'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 200, // changed to 200 as requested
                  child: Obx(() {
                    final ctrlLatLng = ctrl.currentLatLng.value;
                    final marker = ctrl.marker.value;
                    if (ctrlLatLng == null)
                      return const Center(child: CircularProgressIndicator());

                    return GoogleMap(
                      onMapCreated: (gmc) => ctrl.mapController.value = gmc,
                      initialCameraPosition:
                          CameraPosition(target: ctrlLatLng, zoom: 15),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      markers: marker != null ? {marker} : {},
                      polygons: {
                        Polygon(
                          polygonId: const PolygonId('allowedArea'),
                          points: ctrl.polygon,
                          // controller getter returns _points
                          strokeWidth: 2,
                          strokeColor: Colors.blue,
                          fillColor: Colors.blue.withOpacity(0.2),
                        ),
                      },
                      onTap: (latlng) async {
                        if (ctrl.pointInPolygon(latlng)) {
                          ctrl.setMarker(latlng, draggable: true);
                          ctrl.updateSelectedInfo(latlng);
                          final addr = await ctrl.reverseGeocode(latlng);
                          if (addr != null) ctrl.addressText.value = addr;
                        } else {
                          Get.snackbar(
                              'Out of Area', 'Tap inside the allowed polygon.',
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                    );
                  }),
                ),
              ),

              const SizedBox(height: 12),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lat: ${ctrl.latText.value}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Lng: ${ctrl.lngText.value}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 16),
              TextField(
                controller: controller.titleController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),
              Obx(() {
                return TextField(
                  controller: controller.apartmentController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: controller.textFieldAddressText.value.isEmpty
                        ? "Enter Apartment  Number"
                        : controller.textFieldAddressText.value,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // 🔘 Default toggle
              _buildDefaultSwitch(),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 24),
        child: Obx(() {
          controller.isoCountryCode.value;
          return ElevatedButton.icon(
            label: const Text(
              'Save Address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.light.buttonGradient2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              ctrl.onAddLocationPressed();
            },
          );
        }),
      ),
    );
  }

  Widget _buildDefaultSwitch() => Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Default Shipping Address",
              style: TextStyle(fontSize: 16)),
          Switch.adaptive(
            value: controller.defaultAddress.value,
            onChanged: controller.toggleDefaultAddress,
            activeColor: Colors.green,
          ),
        ],
      ));
}
