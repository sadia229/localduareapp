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
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        _franchisesList.value = FranchisesModel.fromJson(responseBody);
        if (_franchisesList.value?.data?.isNotEmpty ?? false) {
          selectedArea.value = _franchisesList.value!.data!.first.sId ?? '';
        }
        debugPrint("Franchises List: ${_franchisesList.value?.toJson()}");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoadingArea.value = false;
    }
  }

  void saveFranchiseId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('franchiseId', selectedFranchiseId.value);
    final franchiseId = prefs.getString('franchiseId');
    if(franchiseId != null){
      Get.toNamed(Routes.SELECT_PHONE_NUMBER);
    }
    else{
      debugPrint("Franchise ID is null $franchiseId");
    }
  }
}
