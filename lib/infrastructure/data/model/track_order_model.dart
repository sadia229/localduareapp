class TrackOrderModel {
  int? statusCode;
  bool? success;
  String? message;
  List<Data>? data;
  Meta? meta;

  TrackOrderModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  TrackOrderModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? orderId;
  CustomerId? customerId;
  ShopId? shopId;
  FranchiseId? franchiseId;
  List<Items>? items;
  int? subtotal;
  int? deliveryCharge;
  int? discountAmount;
  int? grandTotal;
  DeliveryAddress? deliveryAddress;
  String? customerPhone;
  String? paymentMethod;
  String? paymentStatus;
  String? status;
  Null? assignedRider;
  int? tip;
  int? bonus;
  String? orderDate;
  String? customerNotes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
    this.orderId,
    this.customerId,
    this.shopId,
    this.franchiseId,
    this.items,
    this.subtotal,
    this.deliveryCharge,
    this.discountAmount,
    this.grandTotal,
    this.deliveryAddress,
    this.customerPhone,
    this.paymentMethod,
    this.paymentStatus,
    this.status,
    this.assignedRider,
    this.tip,
    this.bonus,
    this.orderDate,
    this.customerNotes,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['orderId'];
    customerId = json['customerId'] != null
        ? new CustomerId.fromJson(json['customerId'])
        : null;
    shopId =
        json['shopId'] != null ? new ShopId.fromJson(json['shopId']) : null;
    franchiseId = json['franchiseId'] != null
        ? new FranchiseId.fromJson(json['franchiseId'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    subtotal = json['subtotal'];
    deliveryCharge = json['deliveryCharge'];
    discountAmount = json['discountAmount'];
    grandTotal = json['grandTotal'];
    deliveryAddress = json['deliveryAddress'] != null
        ? new DeliveryAddress.fromJson(json['deliveryAddress'])
        : null;
    customerPhone = json['customerPhone'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    status = json['status'];
    assignedRider = json['assignedRider'];
    tip = json['tip'];
    bonus = json['bonus'];
    orderDate = json['orderDate'];
    customerNotes = json['customerNotes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['orderId'] = this.orderId;
    if (this.customerId != null) {
      data['customerId'] = this.customerId!.toJson();
    }
    if (this.shopId != null) {
      data['shopId'] = this.shopId!.toJson();
    }
    if (this.franchiseId != null) {
      data['franchiseId'] = this.franchiseId!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['subtotal'] = this.subtotal;
    data['deliveryCharge'] = this.deliveryCharge;
    data['discountAmount'] = this.discountAmount;
    data['grandTotal'] = this.grandTotal;
    if (this.deliveryAddress != null) {
      data['deliveryAddress'] = this.deliveryAddress!.toJson();
    }
    data['customerPhone'] = this.customerPhone;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentStatus'] = this.paymentStatus;
    data['status'] = this.status;
    data['assignedRider'] = this.assignedRider;
    data['tip'] = this.tip;
    data['bonus'] = this.bonus;
    data['orderDate'] = this.orderDate;
    data['customerNotes'] = this.customerNotes;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CustomerId {
  String? sId;
  String? phone;

  CustomerId({this.sId, this.phone});

  CustomerId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phone'] = this.phone;
    return data;
  }
}

class ShopId {
  String? sId;
  String? name;
  String? category;
  Address? address;

  ShopId({this.sId, this.name, this.category, this.address});

  ShopId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    category = json['category'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['category'] = this.category;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  String? street;
  String? area;
  String? city;
  String? district;
  String? division;
  String? postalCode;
  Coordinates? coordinates;
  String? locationDescription;

  Address({
    this.street,
    this.area,
    this.city,
    this.district,
    this.division,
    this.postalCode,
    this.coordinates,
    this.locationDescription,
  });

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    area = json['area'];
    city = json['city'];
    district = json['district'];
    division = json['division'];
    postalCode = json['postalCode'];
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
    locationDescription = json['locationDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['area'] = this.area;
    data['city'] = this.city;
    data['district'] = this.district;
    data['division'] = this.division;
    data['postalCode'] = this.postalCode;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    data['locationDescription'] = this.locationDescription;
    return data;
  }
}

class Coordinates {
  String? type;
  List<double>? coordinates;

  Coordinates({this.type, this.coordinates});

  Coordinates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class FranchiseId {
  String? sId;
  String? name;

  FranchiseId({this.sId, this.name});

  FranchiseId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Items {
  String? itemId;
  String? itemType;
  String? name;
  int? quantity;
  int? unitPrice;
  int? totalPrice;
  String? notes;

  Items({
    this.itemId,
    this.itemType,
    this.name,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.notes,
  });

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemType = json['itemType'];
    name = json['name'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemType'] = this.itemType;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    data['totalPrice'] = this.totalPrice;
    data['notes'] = this.notes;
    return data;
  }
}

class DeliveryAddress {
  String? type;
  String? label;
  String? street;
  String? city;
  String? district;
  String? division;
  String? landmark;
  String? phone;
  Coordinates? coordinates;
  String? sId;

  DeliveryAddress(
      {this.type,
      this.label,
      this.street,
      this.city,
      this.district,
      this.division,
      this.landmark,
      this.phone,
      this.coordinates,
      this.sId});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    label = json['label'];
    street = json['street'];
    city = json['city'];
    district = json['district'];
    division = json['division'];
    landmark = json['landmark'];
    phone = json['phone'];
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['label'] = this.label;
    data['street'] = this.street;
    data['city'] = this.city;
    data['district'] = this.district;
    data['division'] = this.division;
    data['landmark'] = this.landmark;
    data['phone'] = this.phone;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Meta {
  String? page;
  String? limit;
  int? total;
  int? totalPages;

  Meta({this.page, this.limit, this.total, this.totalPages});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['totalPages'] = this.totalPages;
    return data;
  }
}
