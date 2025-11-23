import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/data/model/cart/cart_item_model.dart';
import '../../../infrastructure/theme/app.colors.dart';
import '../controllers/cart.controller.dart';
import 'cart_shimmer.dart';

class CartItems extends GetView<CartController> {
  const CartItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 12),
          itemCount: 2,
          itemBuilder: (context, index) => const CartItemShimmer(),
        );
      }
      if (controller.cartItems.isEmpty) {
        return SizedBox(
          height: Get.size.height * 0.5,
          child: Center(
            child: Text(
              "Your cart is empty 🛒",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final item = controller.cartItems[index];
          return Dismissible(
            key: Key(item.itemId.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              color: AppColors.light.buttonGradient2,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Remove Item"),
                    content: const Text(
                        "Are you sure you want to remove this item from cart?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("CANCEL"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                          controller.removeItem(item);
                        },
                        child: const Text("REMOVE",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
            onDismissed: (direction) {},
            child: _buildCardItem(
              item: item,
              price: controller.subtotal.value,
              removeButton: () => controller.decreaseQuantity(item),
              addButton: () => controller.increaseQuantity(item),
            ),
          );
        },
      );
    });
  }
}

class _buildCardItem extends StatelessWidget {
  final CartItemsModel item;
  final double price;
  final VoidCallback removeButton;
  final VoidCallback addButton;

  const _buildCardItem({
    super.key,
    required this.item,
    required this.price,
    required this.removeButton,
    required this.addButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.itemsImage,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.itemsName,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  item.shopName,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      //"BDT ${price.toStringAsFixed(2)}",
                      "BDT ${item.itemsPrice.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Quantity Selector
                    Row(
                      children: [
                        InkWell(
                          // onPressed: () =>
                          //     controller.decreaseQuantity(item),
                          onTap: removeButton,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 18,
                              color: AppColors.light.primaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            item.quantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        InkWell(
                          // onPressed: () =>
                          //     controller.increaseQuantity(item),
                          onTap: addButton,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 18,
                              color: AppColors.light.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
