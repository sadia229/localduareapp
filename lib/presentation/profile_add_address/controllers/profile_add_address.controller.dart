import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../get_delivery_address/controllers/get_delivery_address.controller.dart';

class ProfileAddAddressController extends GetxController
    with WidgetsBindingObserver {
  final isLoading = true.obs;
  final currentPosition = Rxn<Position>();
  final currentLatLng = Rxn<LatLng>();
  final mapController = Rxn<GoogleMapController>();
  final marker = Rxn<Marker>();
  final addressText = ''.obs;
  final textFieldAddressText = ''.obs;
  final latText = ''.obs;
  final lngText = ''.obs;
  final street = ''.obs;
  final name = ''.obs;
  final thoroughfare = ''.obs;
  final locality = ''.obs;
  final postalCode = ''.obs;
  final country = ''.obs;
  final isoCountryCode = ''.obs;
  final titleController = TextEditingController();
  final apartmentController = TextEditingController();
  final defaultAddress = false.obs;
  final isEditing = false.obs;
  final editingIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    //_determinePosition();
    // Check for edit mode
    final args = Get.arguments;
    if (args != null && args['address'] != null) {
      final address = args['address'] as Map<String, dynamic>;
      editingIndex.value = args['index'];
      isEditing.value = true;

      // Prefill text and reactive values
      titleController.text = address['label'] ?? '';
      street.value = address['street'] ?? '';
      thoroughfare.value = address['area'] ?? '';
      locality.value = address['city'] ?? '';
      country.value = address['landmark'] ?? '';
      latText.value = (address['coordinates']['coordinates'][1]).toString();
      lngText.value = (address['coordinates']['coordinates'][0]).toString();

      // Set marker position
      final lat = address['coordinates']['coordinates'][1];
      final lng = address['coordinates']['coordinates'][0];
      final latLng = LatLng(lat, lng);
      currentLatLng.value = latLng;
      setMarker(latLng, draggable: true);
      _animateTo(latLng);
    } else {
      // Normal add mode
      _determinePosition();
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Location Disabled', 'Please enable location services.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Permission Denied', 'Location permission is required.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
          'Permission Denied', 'Enable location permissions in settings.');
      return;
    }

    // ✅ Get current position
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentPosition.value = position;
    final latLng = LatLng(position.latitude, position.longitude);
    currentLatLng.value = latLng;

    // ✅ Update marker, camera, and address
    setMarker(latLng, draggable: true);
    _animateTo(latLng);
    updateSelectedInfo(latLng);
    latText.value = position.latitude.toStringAsFixed(6);
    lngText.value = position.longitude.toStringAsFixed(6);

    // ❌ old line (caused error)
    // addressText.value = await reverseGeocode(position);

    // ✅ fixed line
    addressText.value = await reverseGeocode(latLng);

    isLoading.value = false;
  }

  Future<String> reverseGeocode(LatLng pos) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isEmpty) return '';
      final p = placemarks.first;

      street.value = p.street ?? '';
      name.value = p.name ?? '';
      thoroughfare.value = p.thoroughfare ?? '';
      locality.value = p.locality ?? '';
      postalCode.value = p.postalCode ?? '';
      country.value = p.country ?? '';
      isoCountryCode.value = p.isoCountryCode ?? '';

      debugPrint('my street: ${street.value}');
      debugPrint('my name: ${name.value}');
      debugPrint('my thoroughfare: ${thoroughfare.value}');
      debugPrint('my locality: ${locality.value}');
      debugPrint('my postalCode: ${postalCode.value}');
      debugPrint('my country: ${country.value}');
      debugPrint('my isoCountryCode: ${isoCountryCode.value}');

      final components = [
        if (p.street?.isNotEmpty ?? false) p.street,
        if (p.subLocality?.isNotEmpty ?? false) p.subLocality,
        if (p.locality?.isNotEmpty ?? false) p.locality,
        if (p.administrativeArea?.isNotEmpty ?? false) p.administrativeArea,
        if (p.postalCode?.isNotEmpty ?? false) p.postalCode,
      ].join(', ');

      textFieldAddressText.value =
          components.isEmpty ? (p.name ?? '') : components;

      return textFieldAddressText.value;
    } catch (e) {
      debugPrint('Reverse geocode failed: $e');
      return "";
    }
  }

  void updateSelectedInfo(LatLng pos) {
    latText.value = pos.latitude.toStringAsFixed(6);
    lngText.value = pos.longitude.toStringAsFixed(6);
  }

  void _animateTo(LatLng pos) {
    mapController.value?.animateCamera(CameraUpdate.newLatLng(pos));
  }

  void setMarker(LatLng pos, {bool draggable = false}) {
    marker.value = Marker(
      markerId: const MarkerId('selectedMarker'),
      position: pos,
      draggable: draggable,
      onDragEnd: (newPos) async {
        // ✅ Update info when marker is moved
        currentLatLng.value = newPos;
        updateSelectedInfo(newPos);
        addressText.value = await reverseGeocode(newPos);
      },
      infoWindow: const InfoWindow(title: 'Selected Location'),
    );
  }

  // Future<void> saveAddressToPrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   // Create the new address object
  //   final newAddress = {
  //     "type": "home",
  //     "label": titleController.text.isEmpty ? "Home" : titleController.text,
  //     "street": street.value,
  //     "area": thoroughfare.value,
  //     "city": locality.value,
  //     "district": locality.value,
  //     "landmark": country.value,
  //     "phone": "+8801712345678",
  //     "coordinates": {
  //       "type": "Point",
  //       "coordinates": [
  //         double.tryParse(lngText.value) ?? 0.0,
  //         double.tryParse(latText.value) ?? 0.0,
  //       ]
  //     }
  //   };
  //
  //   // Load existing addresses (if any)
  //   final existingString = prefs.getString('saved_addresses');
  //   List<dynamic> addressList = [];
  //
  //   if (existingString != null) {
  //     addressList = jsonDecode(existingString);
  //   }
  //
  //   // Add the new one
  //   addressList.add(newAddress);
  //
  //   // Save the updated list
  //   await prefs.setString('saved_addresses', jsonEncode(addressList));
  //   Get.snackbar('Success', 'Address saved successfully!');
  //   Get.find<GetDeliveryAddressController>().loadSavedAddress();
  //   Get.back();
  // }
  Future<void> saveAddressToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    // Build the address object
    final newAddress = {
      "type": "home",
      "label": titleController.text.isEmpty ? "Home" : titleController.text,
      "street": street.value,
      "area": thoroughfare.value,
      "city": locality.value,
      "district": locality.value,
      "landmark": country.value,
      "phone": "+8801712345678",
      "coordinates": {
        "type": "Point",
        "coordinates": [
          double.tryParse(lngText.value) ?? 0.0,
          double.tryParse(latText.value) ?? 0.0,
        ]
      }
    };

    // Load existing list
    final existingString = prefs.getString('saved_addresses');
    List<dynamic> addressList = [];
    if (existingString != null) {
      addressList = jsonDecode(existingString);
    }

    // ✅ If editing, update the existing index
    if (isEditing.value) {
      if (editingIndex.value >= 0 && editingIndex.value < addressList.length) {
        addressList[editingIndex.value] = newAddress;
        Get.snackbar('Updated', 'Address updated successfully!');
        Get.back();
      } else {
        // Safety check in case of invalid index
        Get.snackbar('Error', 'Invalid address index!');
        return;
      }
    } else {
      // ✅ Otherwise, add as new
      addressList.add(newAddress);
      Get.snackbar('Success', 'Address saved successfully!');
      Get.back();
    }

    // Save updated list
    await prefs.setString('saved_addresses', jsonEncode(addressList));

    // Refresh delivery address list and close
    Get.find<GetDeliveryAddressController>().loadSavedAddress();
    debugPrint("hahahahahahah");
    //Get.back();
    //Get.toNamed(Routes.PROFILE_ADD_ADDRESS);
  }

  void toggleDefaultAddress(bool value) => defaultAddress.value = value;
}
