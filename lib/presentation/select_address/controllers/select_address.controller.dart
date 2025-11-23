import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/data/model/franchises_model.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/static/project.constants.dart';

class SelectAddressController extends GetxController {
  final areaName = ''.obs;
  final selectedArea = ''.obs;
  final selectedFranchiseId = ''.obs;
  final _isLoadingArea = false.obs;

  bool get isLoadingArea => _isLoadingArea.value;
  final _franchisesList = Rxn<FranchisesModel>();

  FranchisesModel? get franchisesList => _franchisesList.value;

  void onAreaNameChanged(String value) {
    areaName.value = value;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchFranchises();
  }

  Future<void> fetchFranchises() async {
    try {
      _isLoadingArea.value = true;
      final response = await http.get(
        Uri.parse('$baseUrl/franchises/active'),
        headers: {"Content-Type": "application/json"},
      );

      debugPrint('Franchises API Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        _franchisesList.value = FranchisesModel.fromJson(responseBody);

        final franchises = _franchisesList.value?.franchises ?? [];
        if (franchises.isNotEmpty) {
          selectedFranchiseId.value = franchises.first.id;
          selectedArea.value = franchises.first.id;
        } else {
          debugPrint('No franchises found.');
        }
      } else {
        throw Exception('Failed to load franchises.');
      }
    } catch (e, st) {
      debugPrint('Error in fetchFranchises: $e\n$st');
      Get.snackbar(
        'Error',
        'Failed to load franchises. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoadingArea.value = false;
    }
  }

  void saveFranchiseId() async {
    final prefs = await SharedPreferences.getInstance();

    // Save selected franchise ID
    await prefs.setString('franchiseId', selectedFranchiseId.value);

    // Find the selected franchise
    final selectedFranchise = _franchisesList.value?.franchises
        .firstWhereOrNull((f) => f.id == selectedFranchiseId.value);

    // Save coordinates if available
    if (selectedFranchise?.area?.coordinates != null) {
      final coordinatesJson =
      jsonEncode(selectedFranchise!.area!.coordinates!.toJson());
      await prefs.setString('coordinates', coordinatesJson);
      debugPrint('Saved Coordinates: $coordinatesJson');
    } else {
      debugPrint('No coordinates found for selected franchise.');
    }

    // Verify and navigate
    final franchiseId = prefs.getString('franchiseId');
    if (franchiseId != null) {
      Get.toNamed(Routes.BOTTOM_NAVBAR);
    } else {
      debugPrint("Franchise ID is null $franchiseId");
    }
  }
}
