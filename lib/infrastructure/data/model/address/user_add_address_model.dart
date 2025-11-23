class UserAddAddressModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  UserAddAddressModel({this.statusCode, this.success, this.message, this.data});

  UserAddAddressModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? phone;
  String? userType;
  String? status;
  Null? franchiseId;
  List<Null>? shopId;
  bool? isPhoneVerified;
  String? lastLogin;
  String? registrationDate;
  String? lastActiveDate;
  CustomerInfo? customerInfo;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.phone,
      this.userType,
      this.status,
      this.franchiseId,
      this.shopId,
      this.isPhoneVerified,
      this.lastLogin,
      this.registrationDate,
      this.lastActiveDate,
      this.customerInfo,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone'];
    userType = json['userType'];
    status = json['status'];
    franchiseId = json['franchiseId'];
    isPhoneVerified = json['isPhoneVerified'];
    lastLogin = json['lastLogin'];
    registrationDate = json['registrationDate'];
    lastActiveDate = json['lastActiveDate'];
    customerInfo = json['customerInfo'] != null
        ? new CustomerInfo.fromJson(json['customerInfo'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phone'] = this.phone;
    data['userType'] = this.userType;
    data['status'] = this.status;
    data['franchiseId'] = this.franchiseId;
    data['isPhoneVerified'] = this.isPhoneVerified;
    data['lastLogin'] = this.lastLogin;
    data['registrationDate'] = this.registrationDate;
    data['lastActiveDate'] = this.lastActiveDate;
    if (this.customerInfo != null) {
      data['customerInfo'] = this.customerInfo!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CustomerInfo {
  int? accountBalance;
  int? totalOrders;
  int? totalSpent;
  int? loyaltyPoints;
  List<Addresses>? addresses;
  int? defaultAddressIndex;
  bool? isSubscribed;
  List<Null>? favouriteShops;

  CustomerInfo(
      {this.accountBalance,
      this.totalOrders,
      this.totalSpent,
      this.loyaltyPoints,
      this.addresses,
      this.defaultAddressIndex,
      this.isSubscribed,
      this.favouriteShops});

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    accountBalance = json['accountBalance'];
    totalOrders = json['totalOrders'];
    totalSpent = json['totalSpent'];
    loyaltyPoints = json['loyaltyPoints'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
    defaultAddressIndex = json['defaultAddressIndex'];
    isSubscribed = json['isSubscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountBalance'] = this.accountBalance;
    data['totalOrders'] = this.totalOrders;
    data['totalSpent'] = this.totalSpent;
    data['loyaltyPoints'] = this.loyaltyPoints;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['defaultAddressIndex'] = this.defaultAddressIndex;
    data['isSubscribed'] = this.isSubscribed;
    return data;
  }
}

class Addresses {
  String? type;
  String? label;
  String? street;
  String? area;
  String? city;
  String? district;
  String? postalCode;
  String? landmark;
  String? phone;
  Coordinates? coordinates;
  String? sId;

  Addresses(
      {this.type,
      this.label,
      this.street,
      this.area,
      this.city,
      this.district,
      this.postalCode,
      this.landmark,
      this.phone,
      this.coordinates,
      this.sId});

  Addresses.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    label = json['label'];
    street = json['street'];
    area = json['area'];
    city = json['city'];
    district = json['district'];
    postalCode = json['postalCode'];
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
    data['area'] = this.area;
    data['city'] = this.city;
    data['district'] = this.district;
    data['postalCode'] = this.postalCode;
    data['landmark'] = this.landmark;
    data['phone'] = this.phone;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    data['_id'] = this.sId;
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
