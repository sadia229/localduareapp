import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localduareapp/infrastructure/data/model/shop_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/static/project.constants.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final _shopList = Rxn<ShopModel>();

  ShopModel? get shopList => _shopList.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchShops();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> fetchShops() async {
    try {
      _isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final franchiseId = prefs.getString('franchiseId');
      debugPrint("Franchise ID: $franchiseId");
      final response = await http.get(
        Uri.parse('$baseUrl/shops/public/franchise/$franchiseId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        _isLoading.value = false;
        final responseBody = json.decode(response.body);
        _shopList.value = ShopModel.fromJson(responseBody);
        debugPrint("All restaurant List: ${_shopList.value?.toJson()}");
      }
    } catch (e) {
      _isLoading.value = false;
      debugPrint("shop error : ${e.toString()}");
    }
  }
}
