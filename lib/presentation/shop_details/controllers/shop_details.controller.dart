import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localduareapp/infrastructure/data/model/shop/shop_menu_model.dart';
import '../../../infrastructure/data/model/shop/shop_details_model.dart';
import '../../../infrastructure/static/project.constants.dart';

class ShopDetailsController extends GetxController
    with GetTickerProviderStateMixin {
  final shopId = "".obs;
  final isLoading = false.obs;
  final shopDetails = Rxn<ShopDetailsModel>();
  final isLoadingMenu = false.obs;
  final shopMenuDetails = Rxn<ShopMenuModel>();
  final selectedCategoryIndex = 0.obs;
  TabController? tabController;
  final itemsLength = 0.obs;
  final shopImageUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    shopId.value = Get.arguments['shopId'];
    shopImageUrl.value = Get.arguments['shopImageUrl'];
    debugPrint("Shop ID: ${shopId.value}");
    _fetchShopDetails();
    _fetchShopMenuDetails();
    // tabController = TabController(
    //   length: 1,
    //   vsync: this,
    // );
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  Future<void> _fetchShopDetails() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/shops/public/${shopId.value}'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final responseBody = json.decode(response.body);
      isLoading.value = false;
      if (response.statusCode == 200) {
        shopDetails.value = ShopDetailsModel.fromJson(responseBody);
        debugPrint("Shop Details: ${shopDetails.value?.toJson()}");
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> _fetchShopMenuDetails() async {
    isLoadingMenu.value = true;
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/menu/shop/${shopId.value}'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final responseBody = json.decode(response.body);
      debugPrint("Shop Menu: ${responseBody}");
      isLoadingMenu.value = false;
      if (response.statusCode == 200) {
        shopMenuDetails.value = ShopMenuModel.fromJson(responseBody);
        debugPrint("Shopxxx Menu: ${shopDetails.value?.toJson()}");
        debugPrint("Shopxxx Menu: ");
        itemsLength.value = shopMenuDetails.value?.data?.sections?.length ?? 0;
        debugPrint("Items Length: ${itemsLength.value}");
        tabController?.dispose();
        tabController = TabController(
          length: itemsLength.value,
          vsync: this,
        );
        tabController?.addListener(() {
          selectedCategoryIndex.value = tabController!.index;
        });
      }
    } catch (e) {
      isLoadingMenu.value = false;
      debugPrint(e.toString());
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }
}
