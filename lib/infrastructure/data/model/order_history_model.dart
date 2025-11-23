class OrderHistoryModel {
  int statusCode;
  bool success;
  String message;
  List<Orders> data;
  Meta meta;

  OrderHistoryModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: List<Orders>.from(json["data"].map((x) => Orders.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Orders {
  String id;
  String orderId;
  CustomerId customerId;
  ShopId shopId;
  FranchiseId franchiseId;
  List<Item> items;
  int subtotal;
  int deliveryCharge;
  int discountAmount;
  int grandTotal;
  DeliveryAddress deliveryAddress;
  String customerPhone;
  String paymentMethod;
  String paymentStatus;
  String status;
  dynamic assignedRider;
  int tip;
  int bonus;
  DateTime orderDate;
  String customerNotes;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Orders({
    required this.id,
    required this.orderId,
    required this.customerId,
    required this.shopId,
    required this.franchiseId,
    required this.items,
    required this.subtotal,
    required this.deliveryCharge,
    required this.discountAmount,
    required this.grandTotal,
    required this.deliveryAddress,
    required this.customerPhone,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.status,
    required this.assignedRider,
    required this.tip,
    required this.bonus,
    required this.orderDate,
    required this.customerNotes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json["_id"] ?? "",
        orderId: json["orderId"] ?? "",
        customerId: CustomerId.fromJson(json["customerId"]),
        shopId: ShopId.fromJson(json["shopId"]),
        franchiseId: FranchiseId.fromJson(json["franchiseId"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        subtotal: json["subtotal"] ?? 0,
        deliveryCharge: json["deliveryCharge"] ?? 0,
        discountAmount: json["discountAmount"] ?? 0,
        grandTotal: json["grandTotal"] ?? 0,
        deliveryAddress: DeliveryAddress.fromJson(json["deliveryAddress"]),
        customerPhone: json["customerPhone"] ?? "",
        paymentMethod: json["paymentMethod"] ?? "",
        paymentStatus: json["paymentStatus"] ?? "",
        status: json["status"] ?? "",
        assignedRider: json["assignedRider"],
        tip: json["tip"] ?? 0,
        bonus: json["bonus"] ?? 0,
        orderDate: DateTime.parse(json["orderDate"]),
        customerNotes: json["customerNotes"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "orderId": orderId,
        "customerId": customerId.toJson(),
        "shopId": shopId.toJson(),
        "franchiseId": franchiseId.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "subtotal": subtotal,
        "deliveryCharge": deliveryCharge,
        "discountAmount": discountAmount,
        "grandTotal": grandTotal,
        "deliveryAddress": deliveryAddress.toJson(),
        "customerPhone": customerPhone,
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
        "status": status,
        "assignedRider": assignedRider,
        "tip": tip,
        "bonus": bonus,
        "orderDate": orderDate.toIso8601String(),
        "customerNotes": customerNotes,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class CustomerId {
  String id;
  String phone;

  CustomerId({
    required this.id,
    required this.phone,
  });

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
        id: json["_id"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
      };
}

class DeliveryAddress {
  String type;
  String label;
  String street;
  String city;
  String district;
  String division;
  String landmark;
  String phone;
  Coordinates coordinates;
  String id;

  DeliveryAddress({
    required this.type,
    required this.label,
    required this.street,
    required this.city,
    required this.district,
    required this.division,
    required this.landmark,
    required this.phone,
    required this.coordinates,
    required this.id,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        type: json["type"],
        label: json["label"],
        street: json["street"],
        city: json["city"],
        district: json["district"],
        division: json["division"],
        landmark: json["landmark"],
        phone: json["phone"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "label": label,
        "street": street,
        "city": city,
        "district": district,
        "division": division,
        "landmark": landmark,
        "phone": phone,
        "coordinates": coordinates.toJson(),
        "_id": id,
      };
}

class Coordinates {
  Type type;
  List<double> coordinates;

  Coordinates({
    required this.type,
    required this.coordinates,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        type: typeValues.map[json["type"]]!,
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

enum Type { POINT }

final typeValues = EnumValues({"Point": Type.POINT});

class FranchiseId {
  String id;
  String name;

  FranchiseId({
    required this.id,
    required this.name,
  });

  factory FranchiseId.fromJson(Map<String, dynamic> json) => FranchiseId(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Item {
  String itemId;
  String itemType;
  String name;
  int quantity;
  int unitPrice;
  int totalPrice;
  String notes;
  List<dynamic> options;

  Item({
    required this.itemId,
    required this.itemType,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.notes,
    required this.options,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["itemId"],
        itemType: json["itemType"],
        name: json["name"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
        totalPrice: json["totalPrice"],
        notes: json["notes"],
        options: List<dynamic>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "itemType": itemType,
        "name": name,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "totalPrice": totalPrice,
        "notes": notes,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}

class ShopId {
  String id;
  String name;
  String category;
  Address address;

  ShopId({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
  });

  factory ShopId.fromJson(Map<String, dynamic> json) => ShopId(
        id: json["_id"],
        name: json["name"],
        category: json["category"],
        address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category": category,
        "address": address.toJson(),
      };
}

class Address {
  String street;
  String area;
  String city;
  String district;
  String division;
  String postalCode;
  Coordinates coordinates;
  String locationDescription;

  Address({
    required this.street,
    required this.area,
    required this.city,
    required this.district,
    required this.division,
    required this.postalCode,
    required this.coordinates,
    required this.locationDescription,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"] ?? "",
        area: json["area"] ?? "",
        city: json["city"] ?? "",
        district: json["district"] ?? "",
        division: json["division"] ?? "",
        postalCode: json["postalCode"] ?? "",
        coordinates: Coordinates.fromJson(json["coordinates"]),
        locationDescription: json["locationDescription"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "area": area,
        "city": city,
        "district": district,
        "division": division,
        "postalCode": postalCode,
        "coordinates": coordinates.toJson(),
        "locationDescription": locationDescription,
      };
}

class Meta {
  int page;
  int limit;
  int total;
  int totalPages;

  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
        "totalPages": totalPages,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
