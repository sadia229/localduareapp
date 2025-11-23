import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/data/model/address/user_add_address_model.dart';
import '../../../infrastructure/static/project.constants.dart';

class GetDeliveryAddressController extends GetxController {
  final count = 0.obs;
  final isLoading = false.obs;
  final _addressList = Rxn<UserAddAddressModel>();

  UserAddAddressModel? get addressList => _addressList.value;
  final savedAddresses = <Map<String, dynamic>>[].obs;
  final selectedAddressIndex = RxnInt();

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchAddresses();
    loadSavedAddress();
    await loadSelectedAddress();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await fetchAddresses();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('$baseUrl/users/addresses'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        final responseBody = json.decode(response.body);
        _addressList.value = UserAddAddressModel.fromJson(responseBody);
        debugPrint("Address List: ${_addressList.value?.toJson()}");
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint("Address error : ${e.toString()}");
    }
  }

  Future<void> loadSavedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('saved_addresses');

    if (jsonString != null) {
      final decoded = jsonDecode(jsonString) as List;
      savedAddresses.assignAll(decoded.cast<Map<String, dynamic>>());
    }
  }

  Future<void> deleteAddress(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final existingString = prefs.getString('saved_addresses');

    if (existingString == null) return;

    // Decode and cast to the correct type
    final List<Map<String, dynamic>> addressList =
        (jsonDecode(existingString) as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();

    if (index >= 0 && index < addressList.length) {
      // Remove locally first
      addressList.removeAt(index);

      // Save to SharedPreferences
      await prefs.setString('saved_addresses', jsonEncode(addressList));

      // ✅ Update reactive list (now correctly typed)
      savedAddresses.value = List<Map<String, dynamic>>.from(addressList);

      Get.snackbar('Deleted', 'Address removed successfully');
    }
  }

  Future<void> removeFromListImmediately(int index) async {
    if (index < 0 || index >= savedAddresses.length) return;

    // ✅ 1. Remove from local list first (fixes dismissible issue)
    final removedItem = savedAddresses[index];
    savedAddresses.removeAt(index);

    // ✅ 2. Update SharedPreferences in background
    final prefs = await SharedPreferences.getInstance();
    final updatedList = savedAddresses.toList();
    await prefs.setString('saved_addresses', jsonEncode(updatedList));

    // ✅ 3. Feedback
    Get.snackbar('Deleted', 'Address removed successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2));

    // ✅ (Optional) Undo button
    // Get.showSnackbar(GetSnackBar(
    //   message: 'Address deleted',
    //   mainButton: TextButton(
    //     onPressed: () {
    //       savedAddresses.insert(index, removedItem);
    //       prefs.setString('saved_addresses', jsonEncode(savedAddresses));
    //       Get.back();
    //     },
    //     child: const Text('UNDO', style: TextStyle(color: Colors.white)),
    //   ),
    //   duration: const Duration(seconds: 2),
    // ));
  }

  Future<void> loadSelectedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('selected_address_index');
    if (index != null && index < savedAddresses.length) {
      selectedAddressIndex.value = index;
    }
  }

  Future<void> saveSelectedAddress(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_address_index', index);
    selectedAddressIndex.value = index;
    if (index >= 0 && index < savedAddresses.length) {
      final selectedAddress = savedAddresses[index];

      final deliveryAddress = {
        "type": selectedAddress['type'] ?? "home",
        "label": selectedAddress['label'] ?? "Home",
        "street": selectedAddress['street'] ?? "",
        "area": selectedAddress['area'] ?? "",
        "city": selectedAddress['city'] ?? "",
        "district": selectedAddress['district'] ?? "",
        "landmark": selectedAddress['landmark'] ?? "",
        "phone": selectedAddress['phone'] ?? "",
        "coordinates": {
          "type": "Point",
          "coordinates": [
            (selectedAddress['coordinates']?['coordinates']?[0]) ?? 0.0,
            (selectedAddress['coordinates']?['coordinates']?[1]) ?? 0.0,
          ],
        },
      };

      await prefs.setString(
        'selected_delivery_address',
        jsonEncode(deliveryAddress),
      );

      debugPrint("✅ Saved delivery address: $deliveryAddress");
    }
  }
}
