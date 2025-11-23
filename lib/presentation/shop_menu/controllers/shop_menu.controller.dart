import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/data/model/cart/cart_item_model.dart';
import '../../../infrastructure/navigation/routes.dart';

class ShopMenuController extends GetxController {
  final quantity = 1.obs;
  final menuId = ''.obs;
  final shopName = ''.obs;
  final menuName = ''.obs;
  final menuImageUrl = ''.obs;
  final menuDescription = ''.obs;
  final menuPrice = 0.obs;
  final shopId = ''.obs;
  var cartItems = <CartItemsModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final args = Get.arguments;
    menuId.value = args['shop_menu_id'];
    menuName.value = args['shop_menu_name'];
    shopName.value = args['shop_name'];
    menuImageUrl.value = args['shop_image'];
    menuDescription.value = args['shop_description'];
    menuPrice.value = args['shop_price'] ?? 0;
    shopId.value = args['shop_id'];
  }

  // void selectSize(String sizeId) {
  //   for (var size in sizes) {
  //     size.isSelected = size.id == sizeId;
  //   }
  //   update();
  // }

  // void toggleOption(String optionId) {
  //   final option = options.firstWhere((opt) => opt.id == optionId);
  //   option.isSelected = !option.isSelected;
  //   update();
  // }

  void increaseQuantity() => quantity.value++;

  void decreaseQuantity() {
    if (quantity.value > 1) quantity.value--;
  }

  Future<void> addToCart() async {
    final prefs = await SharedPreferences.getInstance();

    // Save shopId (optional)
    final localShopId = await prefs.getString("franchiseId");
    debugPrint("LocalShop ID: $localShopId");
    // if (localShopId != shopId.value) {
    //   Get.snackbar(
    //     "Sorry",
    //     "You can't add items from different shops to the cart.",
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red.shade100,
    //     colorText: Colors.black,
    //     margin: const EdgeInsets.all(12),
    //     duration: const Duration(seconds: 2),
    //     icon: const Icon(Icons.error_outline, color: Colors.blue),
    //   );
    // } else {
      // Load existing items from SharedPreferences
      final List<String> savedCartJson = prefs.getStringList("cartItems") ?? [];
      final List<CartItemsModel> existingCart = savedCartJson
          .map((item) => CartItemsModel.fromJson(jsonDecode(item)))
          .toList();

      // Check if this product already exists
      final existingIndex =
          existingCart.indexWhere((item) => item.itemId == menuId.value);

      if (existingIndex != -1) {
        // Item already in cart → replace its quantity with new value
        final existingItem = existingCart[existingIndex];

        final updatedQuantity =
            quantity.value; // Replace old quantity with new one
        existingCart[existingIndex] = CartItemsModel(
          itemId: existingItem.itemId,
          itemType: existingItem.itemType,
          quantity: updatedQuantity,
          notes: existingItem.notes,
          itemsName: existingItem.itemsName,
          itemsImage: existingItem.itemsImage,
          shopName: existingItem.shopName,
          itemsPrice: menuPrice.value * updatedQuantity,
        );

        // Show snackbar
        Get.snackbar(
          "Cart Updated",
          "Quantity updated for ${existingItem.itemsName}.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black,
          margin: const EdgeInsets.all(12),
          duration: const Duration(seconds: 2),
          icon: const Icon(Icons.check_circle_outline, color: Colors.green),
        );
      } else {
        // Item not in cart → add new one
        final newItem = CartItemsModel(
          itemId: menuId.value,
          itemType: "menu_item",
          quantity: quantity.value,
          notes: "",
          itemsName: menuName.value,
          itemsImage: menuImageUrl.value,
          shopName: shopName.value,
          itemsPrice: menuPrice.value * quantity.value,
        );

        existingCart.add(newItem);

        Get.snackbar(
          "Added to Cart",
          "${menuName.value} added successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.shade100,
          colorText: Colors.black,
          margin: const EdgeInsets.all(12),
          duration: const Duration(seconds: 2),
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.blue),
        );
      }

      // Save the updated cart list
      final updatedCartJson =
          existingCart.map((item) => jsonEncode(item.toJson())).toList();
      await prefs.setStringList("cartItems", updatedCartJson);

      // Optional: update your local controller list if needed
      cartItems.value = existingCart;

      prefs.setString("xxshopId", shopId.value);
      // Navigate to cart page
      Get.toNamed(Routes.CART);

      debugPrint("🛒 Updated Cart Items: $updatedCartJson");
    //}
  }

// void toggleFavorite() {
//   isFavorite.value = !isFavorite.value;
//   // Implement favorite logic
//   Get.snackbar('Favorite', 'Added to favorites');
// }
//
// void goToNextImage() {
//   if (currentImageIndex.value < itemImages.length - 1) {
//     currentImageIndex.value++;
//   }
// }
//
// void goToPreviousImage() {
//   if (currentImageIndex.value > 0) {
//     currentImageIndex.value--;
//   }
// }
}
