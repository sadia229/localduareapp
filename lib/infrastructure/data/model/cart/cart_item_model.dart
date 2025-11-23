class CartItemsModel {
  final String itemId;
  final String itemsName;
  final String itemsImage;
  final String shopName;
  final num itemsPrice;
  final String itemType;
  final int quantity;
  final String? notes;

  CartItemsModel({
    required this.itemId,
    required this.itemType,
    required this.quantity,
    this.notes,
    required this.itemsName,
    required this.itemsImage,
    required this.shopName,
    required this.itemsPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemType': itemType,
      'quantity': quantity,
      'notes': notes,
      'itemsName': itemsName,
      'itemsImage': itemsImage,
      'shopName': shopName,
      'itemsPrice': itemsPrice,
    };
  }

  factory CartItemsModel.fromJson(Map<String, dynamic> json) {
    return CartItemsModel(
      itemId: json['itemId'],
      itemType: json['itemType'],
      quantity: json['quantity'],
      notes: json['notes'],
      itemsName: json['itemsName'],
      itemsImage: json['itemsImage'],
      shopName: json['shopName'],
      itemsPrice: json['itemsPrice'],
    );
  }

  @override
  String toString() {
    return 'CartItemsModel(itemId: $itemId, itemType: $itemType, quantity: $quantity, notes: $notes, itemsName: $itemsName, itemsImage: $itemsImage, shopName: $shopName, itemsPrice: $itemsPrice)';
  }
}
