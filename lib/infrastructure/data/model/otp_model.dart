class OtpModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  OtpModel({this.statusCode, this.success, this.message, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? accessToken;
  String? refreshToken;
  String? expiresIn;

  Data({this.user, this.accessToken, this.refreshToken, this.expiresIn});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    expiresIn = json['expiresIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['expiresIn'] = this.expiresIn;
    return data;
  }
}

class User {
  String? sId;
  String? phone;
  String? userType;
  String? status;
  bool? isPhoneVerified;
  bool? isProfileComplete;
  CustomerInfo? customerInfo;
  String? registrationDate;
  String? lastActiveDate;
  String? createdAt;
  String? updatedAt;
  String? lastLogin;

  User({
    this.sId,
    this.phone,
    this.userType,
    this.status,
    this.isPhoneVerified,
    this.isProfileComplete,
    this.customerInfo,
    this.registrationDate,
    this.lastActiveDate,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone'];
    userType = json['userType'];
    status = json['status'];
    isPhoneVerified = json['isPhoneVerified'];
    isProfileComplete = json['isProfileComplete'];
    customerInfo = json['customerInfo'] != null
        ? new CustomerInfo.fromJson(json['customerInfo'])
        : null;
    registrationDate = json['registrationDate'];
    lastActiveDate = json['lastActiveDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phone'] = this.phone;
    data['userType'] = this.userType;
    data['status'] = this.status;
    data['isPhoneVerified'] = this.isPhoneVerified;
    data['isProfileComplete'] = this.isProfileComplete;
    if (this.customerInfo != null) {
      data['customerInfo'] = this.customerInfo!.toJson();
    }
    data['registrationDate'] = this.registrationDate;
    data['lastActiveDate'] = this.lastActiveDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['lastLogin'] = this.lastLogin;
    return data;
  }
}

class CustomerInfo {
  int? accountBalance;
  int? totalOrders;
  int? totalSpent;
  int? loyaltyPoints;
  int? defaultAddressIndex;
  bool? isSubscribed;

  CustomerInfo({
    this.accountBalance,
    this.totalOrders,
    this.totalSpent,
    this.loyaltyPoints,
    this.defaultAddressIndex,
    this.isSubscribed,
  });

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    accountBalance = json['accountBalance'];
    totalOrders = json['totalOrders'];
    totalSpent = json['totalSpent'];
    loyaltyPoints = json['loyaltyPoints'];
    defaultAddressIndex = json['defaultAddressIndex'];
    isSubscribed = json['isSubscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountBalance'] = this.accountBalance;
    data['totalOrders'] = this.totalOrders;
    data['totalSpent'] = this.totalSpent;
    data['loyaltyPoints'] = this.loyaltyPoints;
    data['defaultAddressIndex'] = this.defaultAddressIndex;
    data['isSubscribed'] = this.isSubscribed;
    return data;
  }
}
