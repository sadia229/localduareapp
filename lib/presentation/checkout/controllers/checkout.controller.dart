import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/data/model/cart/cart_item_model.dart';
import '../../../infrastructure/data/model/payment_method_model.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/static/project.constants.dart';

class CheckoutController extends GetxController {
  final subTotal = 0.0.obs;
  final deliveryCharge = 0.0.obs;
  final total = 0.0.obs;
  final specialInstructionController = TextEditingController();

  // Payment methods
  final List<PaymentMethodModel> paymentMethods = [
    PaymentMethodModel(
      id: 'cash_on_delivery',
      name: 'Cash on Delivery',
      description: 'Pay with cash upon delivery',
    ),
    PaymentMethodModel(
      id: 'bkash',
      name: 'bKash',
      description: 'Pay with bKash wallet',
      icon: 'assets/images/bkash.png',
      isPopular: true,
    ),
    // Add more payment methods as needed
  ];
  final cartItems = <CartItemsModel>[].obs;
  final isLoading = false.obs;
  final isOrderPlaceLoading = false.obs;
  final deliveryAddress = Rxn<Map<String, dynamic>>();

  @override
  Future<void> onInit() async {
    super.onInit();
    final args = Get.arguments;
    subTotal.value = args['sub_total'];
    deliveryCharge.value = args['delivery_charge'];
    total.value = args['total'];
    await loadCartItems();
    await loadDeliveryAddress();
  }

  final selectedPaymentMethod = Rxn<PaymentMethodModel>();

  final specialInstructions = ''.obs;

  void selectPaymentMethod(PaymentMethodModel method) {
    selectedPaymentMethod.value = method;
  }

  void updateSpecialInstructions(String instructions) {
    specialInstructions.value = instructions;
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

    isLoading.value = false;

    debugPrint("🛒 Loaded Cart Items: ${cartItems.toJson()}");
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

  Future<void> placeOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final shopId = await prefs.getString("xxshopId");
    try {
      isOrderPlaceLoading.value = true;
      final address = deliveryAddress.value!;
      final coordinates = address['coordinates']?['coordinates'] ?? [0.0, 0.0];
      final lon = coordinates[0];
      final lat = coordinates[1];
      final List<Map<String, dynamic>> items = cartItems.map((item) {
        return {
          "itemId": item.itemId,
          "itemType": item.itemType ?? "menu_item",
          "quantity": item.quantity,
          "notes": item.notes ?? "",
        };
      }).toList();

      final body = json.encode({
        "shopId": shopId,
        "items": items,
        "deliveryAddress": {
          "type": "home",
          "label": "home",
          "street": address['street'] ?? "",
          "city": address['city'] ?? "",
          "district": address['district'] ?? "",
          "division": address['division'] ?? "",
          "landmark": address['landmark'] ?? "",
          "phone": address['phone'] ?? "",
          "coordinates": {
            "type": "Point",
            "coordinates": [lat, lon],
          },
        },
        "paymentMethod": selectedPaymentMethod.value?.id ?? "cod",
        "customerNotes": specialInstructionController.text.trim(),
        // "orderAmount": total.value,
      });

      debugPrint("📝 Order Body: $body");
      final response = await http.post(
        Uri.parse('$baseUrl/orders/create'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );
      debugPrint("Order PLace Body: ${body}");
      final responseBody = json.decode(response.body);
      debugPrint("Order PLace response: ${response.body}");
      isOrderPlaceLoading.value = false;
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        debugPrint("✅ Order placed successfully: $responseBody");
        cartItems.clear();
        await prefs.remove("cartItems");
        if (selectedPaymentMethod.value?.id == "bkash") {
          await bkashPayment(responseBody['data']['orderId']);
        } else {
          Get.toNamed(Routes.ORDER_PLACE_SUCCESS);
        }
      }
    } catch (e) {
      isOrderPlaceLoading.value = false;
      debugPrint("Order Place Error: $e");
      debugPrint(e.toString());
    }
  }

  Future<void> bkashPayment(String shopId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final body = json.encode({
        "orderId": shopId,
        "amount": total.value.round(),
        "payerReference": "+8801721530226",
        "frontendBaseUrl": "duareapp://payment",
      });
      final response = await http.post(
        Uri.parse('$baseUrl/payments/bkash/initiate'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );
      debugPrint("Bkash Payment Body: ${body}");
      final responseBody = json.decode(response.body);
      debugPrint("Bkash Payment response: ${response.body}");
      debugPrint("Bkash Payment response: ");
      Get.toNamed(
        Routes.BKASH_WEBVIEW,
        arguments: {
          "url": responseBody['data']['checkoutURL'],
        },
      );
    } catch (e) {
      debugPrint("Bkash Payment Error: $e");
      debugPrint(e.toString());
    }
  }
}
