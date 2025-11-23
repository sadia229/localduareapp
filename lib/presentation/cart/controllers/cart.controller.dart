import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/data/model/cart/cart_item_model.dart';
import '../../../infrastructure/static/project.constants.dart';

class CartController extends GetxController {
  final discount = 0.0.obs;
  final subtotal = 0.0.obs;
  final total = 0.0.obs;
  final deliveryCharge = 20.0.obs;
  final isLoading = false.obs;
  final customTipController = TextEditingController().obs;
  final cartItems = <CartItemsModel>[].obs;
  final _isLoading = false.obs;
  final deliveryAddress = Rxn<Map<String, dynamic>>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadCartItems();
    await loadDeliveryAddress();
    await getDeliveryCharge();
    debugPrint("🚚 Delivery Charge from onint: ${deliveryCharge.value}");
  }

  Future<void> loadCartItems() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedCart = prefs.getStringList("cartItems");

    if (savedCart != null) {
      cartItems.value = savedCart
          .map((item) => CartItemsModel.fromJson(jsonDecode(item)))
          .toList();
    } else {
      cartItems.clear();
    }

    _calculateTotals();
    isLoading.value = false;

    debugPrint("🛒 Loaded Cart Items: ${cartItems.toJson()}");
  }

  void increaseQuantity(CartItemsModel item) async {
    final index = cartItems.indexWhere((e) => e.itemId == item.itemId);
    if (index != -1) {
      final updatedItem = CartItemsModel(
        itemId: item.itemId,
        itemType: item.itemType,
        quantity: item.quantity + 1,
        notes: item.notes,
        itemsName: item.itemsName,
        itemsImage: item.itemsImage,
        shopName: item.shopName,
        itemsPrice: (item.itemsPrice / item.quantity) * (item.quantity + 1),
      );
      cartItems[index] = updatedItem;
      await _saveCart();
      _calculateTotals();
    }
  }

  void decreaseQuantity(CartItemsModel item) async {
    final index = cartItems.indexWhere((e) => e.itemId == item.itemId);
    if (index == -1) return;

    if (item.quantity > 1) {
      final updatedItem = CartItemsModel(
          itemId: item.itemId,
          itemType: item.itemType,
          quantity: item.quantity - 1,
          notes: item.notes,
          itemsName: item.itemsName,
          itemsImage: item.itemsImage,
          shopName: item.shopName,
          itemsPrice: (item.itemsPrice / item.quantity) * (item.quantity - 1));
      cartItems[index] = updatedItem;
      await _saveCart();
      _calculateTotals();
    } else {
      Get.defaultDialog(
        title: "Remove Item",
        middleText: "Are you sure you want to delete this item?",
        textConfirm: "Yes",
        textCancel: "No",
        confirmTextColor: Colors.white,
        onConfirm: () {
          removeItem(item);
          Get.back();
        },
        onCancel: () => Get.back(),
      );
    }
  }

  void removeItem(CartItemsModel item) async {
    cartItems.removeWhere((e) => e.itemId == item.itemId);
    await _saveCart();
    _calculateTotals();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson =
        cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList("cartItems", cartItemsJson);
    debugPrint("🛒 Saved Cart Items: $cartItemsJson");
  }

  Future<void> getDeliveryCharge() async {
    debugPrint("Delivery Chargexxxxxxxx start");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final shopId = await prefs.getString("xxshopId");
    final lat = await prefs.getDouble("order_updated_lat");
    final lon = await prefs.getDouble("order_updated_lng");
    debugPrint("DeliveryAddress Latitude: $lat, DeliveryAddress Longitude: $lon");
    try {
      _isLoading.value = true;
      var body = json.encode({
        "shopId": shopId,
        "latitude": lat,
        "longitude": lon,
        "orderAmount": total.value,
      });
      final response = await http.post(
        Uri.parse('$baseUrl/delivery/calculate'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );
      debugPrint("Delivery Chargexxxxxxxx body: ${body}");
      final responseBody = json.decode(response.body);
      debugPrint("Delivery Chargexxxxxxxx response: ${response.body}");
      _isLoading.value = false;
      if (response.statusCode == 200) {
        final data = responseBody['data'] ?? {};
        final breakdown = data['breakdown'] ?? {};
        deliveryCharge.value = (breakdown['additionalCharge'] ?? 0).toDouble();
        debugPrint("Sadia Chargexxxxxxxx: ${deliveryCharge.value}");
        debugPrint("Response Body: ${responseBody}");
        debugPrint("Response Body: ");
        _calculateTotals();
      }
    } catch (e) {
      _isLoading.value = false;
      debugPrint("Delivery Chargexxxxxxxx Error: $e");
      debugPrint(e.toString());
    }
  }

  void _calculateTotals() {
    double sub = 0.0;
    for (var item in cartItems) {
      sub += item.itemsPrice;
    }

    subtotal.value = sub;
    total.value = sub - discount.value + deliveryCharge.value;

    debugPrint("💰 Subtotal: ${subtotal.value}");
    debugPrint("🚚 Delivery Charge: ${deliveryCharge.value}");
    debugPrint("🏷️ Discount: ${discount.value}");
    debugPrint("🧾 Total: ${total.value}");
  }

  Future<void> loadDeliveryAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('selected_delivery_address');
    if (jsonString != null) {
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      deliveryAddress.value = decoded;
      debugPrint("🟢 Loaded delivery address: $decoded");
    } else {
      debugPrint("⚠️ No delivery address found in SharedPreferences");
    }
  }
}
