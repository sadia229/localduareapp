class ShopDetailsModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final ShopData? data;

  ShopDetailsModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory ShopDetailsModel.fromJson(Map<String, dynamic> json) => ShopDetailsModel(
        statusCode: json['statusCode'],
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? ShopData.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class ShopData {
  final String? id;
  final String? shopId;
  final String? name;
  final String? slug;
  final String? description;
  final Franchise? franchise;
  final Category? category;
  final Owner? owner;
  final String? shopType;
  final Address? address;
  final Contact? contact;
  final Images? images;
  final List<OperatingHour>? operatingHours;
  final BusinessInfo? businessInfo;
  final CategorySpecificSettings? categorySpecificSettings;
  final ServiceSettings? serviceSettings;
  final FinancialSettings? financialSettings;
  final bool? isActive;
  final bool? isVerified;
  final bool? isOpenNow;
  final String? status;

  ShopData({
    this.id,
    this.shopId,
    this.name,
    this.slug,
    this.description,
    this.franchise,
    this.category,
    this.owner,
    this.shopType,
    this.address,
    this.contact,
    this.images,
    this.operatingHours,
    this.businessInfo,
    this.categorySpecificSettings,
    this.serviceSettings,
    this.financialSettings,
    this.status,
    this.isActive,
    this.isVerified,
    this.isOpenNow,
  });

  factory ShopData.fromJson(Map<String, dynamic> json) => ShopData(
        id: json['_id'] ?? json['id'],
        shopId: json['shopId'],
        name: json['name'],
        slug: json['slug'],
        description: json['description'],
        franchise: json['franchise'] != null
            ? Franchise.fromJson(json['franchise'])
            : null,
        category: json['category'] != null
            ? Category.fromJson(json['category'])
            : null,
        owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
        shopType: json['shopType'],
        address:
            json['address'] != null ? Address.fromJson(json['address']) : null,
        contact:
            json['contact'] != null ? Contact.fromJson(json['contact']) : null,
        images: json['images'] != null ? Images.fromJson(json['images']) : null,
        operatingHours: json['operatingHours'] != null
            ? List<OperatingHour>.from(
                json['operatingHours'].map((x) => OperatingHour.fromJson(x)))
            : [],
        businessInfo: json['businessInfo'] != null
            ? BusinessInfo.fromJson(json['businessInfo'])
            : null,
        categorySpecificSettings: json['categorySpecificSettings'] != null
            ? CategorySpecificSettings.fromJson(
                json['categorySpecificSettings'])
            : null,
        serviceSettings: json['serviceSettings'] != null
            ? ServiceSettings.fromJson(json['serviceSettings'])
            : null,
        financialSettings: json['financialSettings'] != null
            ? FinancialSettings.fromJson(json['financialSettings'])
            : null,
        status: json['status'],
        isActive: json['isActive'],
        isVerified: json['isVerified'],
        isOpenNow: json['isOpenNow'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "shopId": shopId,
        "name": name,
        "slug": slug,
        "description": description,
        "franchise": franchise?.toJson(),
        "category": category?.toJson(),
        "owner": owner?.toJson(),
        "shopType": shopType,
        "address": address?.toJson(),
        "contact": contact?.toJson(),
        "images": images?.toJson(),
        "operatingHours": operatingHours?.map((x) => x.toJson()).toList(),
        "businessInfo": businessInfo?.toJson(),
        "categorySpecificSettings": categorySpecificSettings?.toJson(),
        "serviceSettings": serviceSettings?.toJson(),
        "financialSettings": financialSettings?.toJson(),
        "status": status,
        "isActive": isActive,
        "isVerified": isVerified,
        "isOpenNow": isOpenNow,
      };
}

// =========================== Nested Models ===========================

class Franchise {
  final String? id;
  final String? name;
  final String? code;
  final String? description;
  final bool? isActive;
  final Area? area;

  Franchise({
    this.id,
    this.name,
    this.code,
    this.description,
    this.isActive,
    this.area,
  });

  factory Franchise.fromJson(Map<String, dynamic> json) => Franchise(
        id: json['_id'],
        name: json['name'],
        code: json['code'],
        description: json['description'],
        isActive: json['isActive'],
        area: json['area'] != null ? Area.fromJson(json['area']) : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "code": code,
        "description": description,
        "isActive": isActive,
        "area": area?.toJson(),
      };
}

class Area {
  final String? name;
  final String? division;
  final String? district;
  final String? thana;
  final String? city;

  Area({
    this.name,
    this.division,
    this.district,
    this.thana,
    this.city,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        name: json['name'],
        division: json['division'],
        district: json['district'],
        thana: json['thana'],
        city: json['city'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "division": division,
        "district": district,
        "thana": thana,
        "city": city,
      };
}

class Category {
  final String? id;
  final String? value;
  final String? label;
  final String? description;
  final String? icon;

  Category({
    this.id,
    this.value,
    this.label,
    this.description,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['_id'] ?? json['id'],
        value: json['value'],
        label: json['label'],
        description: json['description'],
        icon: json['icon'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "value": value,
        "label": label,
        "description": description,
        "icon": icon,
      };
}

class Owner {
  final String? id;
  final String? name;
  final String? phone;
  final String? email;

  Owner({
    this.id,
    this.name,
    this.phone,
    this.email,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json['_id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "email": email,
      };
}

class Address {
  final String? street;
  final String? area;
  final String? city;
  final String? district;
  final String? division;
  final String? postalCode;

  Address({
    this.street,
    this.area,
    this.city,
    this.district,
    this.division,
    this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json['street'],
        area: json['area'],
        city: json['city'],
        district: json['district'],
        division: json['division'],
        postalCode: json['postalCode'],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "area": area,
        "city": city,
        "district": district,
        "division": division,
        "postalCode": postalCode,
      };
}

class Contact {
  final String? primaryPhone;
  final String? email;
  final Map<String, dynamic>? socialMedia;

  Contact({
    this.primaryPhone,
    this.email,
    this.socialMedia,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        primaryPhone: json['primaryPhone'],
        email: json['email'],
        socialMedia: json['socialMedia'] != null
            ? Map<String, dynamic>.from(json['socialMedia'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "primaryPhone": primaryPhone,
        "email": email,
        "socialMedia": socialMedia,
      };
}

class Images {
  final String? logo;
  final String? banner;
  final List<String>? gallery;

  Images({
    this.logo,
    this.banner,
    this.gallery,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        logo: json['logo'],
        banner: json['banner'],
        gallery:
            json['gallery'] != null ? List<String>.from(json['gallery']) : [],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
        "banner": banner,
        "gallery": gallery,
      };
}

class OperatingHour {
  final String? day;
  final String? open;
  final String? close;
  final bool? isOpen;
  final bool? isHoliday;

  OperatingHour({
    this.day,
    this.open,
    this.close,
    this.isOpen,
    this.isHoliday,
  });

  factory OperatingHour.fromJson(Map<String, dynamic> json) => OperatingHour(
        day: json['day'],
        open: json['open'],
        close: json['close'],
        isOpen: json['isOpen'],
        isHoliday: json['isHoliday'],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "open": open,
        "close": close,
        "isOpen": isOpen,
        "isHoliday": isHoliday,
      };
}

class BusinessInfo {
  final String? tradeLicense;
  final String? businessRegistrationNumber;
  final String? establishedDate;
  final String? businessType;

  BusinessInfo({
    this.tradeLicense,
    this.businessRegistrationNumber,
    this.establishedDate,
    this.businessType,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) => BusinessInfo(
        tradeLicense: json['tradeLicense'],
        businessRegistrationNumber: json['businessRegistrationNumber'],
        establishedDate: json['establishedDate'],
        businessType: json['businessType'],
      );

  Map<String, dynamic> toJson() => {
        "tradeLicense": tradeLicense,
        "businessRegistrationNumber": businessRegistrationNumber,
        "establishedDate": establishedDate,
        "businessType": businessType,
      };
}

class CategorySpecificSettings {
  final String? type;

  CategorySpecificSettings({this.type});

  factory CategorySpecificSettings.fromJson(Map<String, dynamic> json) =>
      CategorySpecificSettings(type: json['type']);

  Map<String, dynamic> toJson() => {"type": type};
}

class ServiceSettings {
  final bool? acceptsOnlineOrders;
  final bool? acceptsPhoneOrders;
  final bool? acceptsPickup;
  final int? estimatedPreparationTime;
  final int? minimumOrderValue;
  final bool? advanceOrderSupport;

  ServiceSettings({
    this.acceptsOnlineOrders,
    this.acceptsPhoneOrders,
    this.acceptsPickup,
    this.estimatedPreparationTime,
    this.minimumOrderValue,
    this.advanceOrderSupport,
  });

  factory ServiceSettings.fromJson(Map<String, dynamic> json) =>
      ServiceSettings(
        acceptsOnlineOrders: json['acceptsOnlineOrders'],
        acceptsPhoneOrders: json['acceptsPhoneOrders'],
        acceptsPickup: json['acceptsPickup'],
        estimatedPreparationTime: json['estimatedPreparationTime'],
        minimumOrderValue: json['minimumOrderValue'],
        advanceOrderSupport: json['advanceOrderSupport'],
      );

  Map<String, dynamic> toJson() => {
        "acceptsOnlineOrders": acceptsOnlineOrders,
        "acceptsPhoneOrders": acceptsPhoneOrders,
        "acceptsPickup": acceptsPickup,
        "estimatedPreparationTime": estimatedPreparationTime,
        "minimumOrderValue": minimumOrderValue,
        "advanceOrderSupport": advanceOrderSupport,
      };
}

class FinancialSettings {
  final PaymentSettings? paymentSettings;

  FinancialSettings({this.paymentSettings});

  factory FinancialSettings.fromJson(Map<String, dynamic> json) =>
      FinancialSettings(
        paymentSettings: json['paymentSettings'] != null
            ? PaymentSettings.fromJson(json['paymentSettings'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "paymentSettings": paymentSettings?.toJson(),
      };
}

class PaymentSettings {
  final bool? acceptsCash;
  final bool? acceptsBkash;
  final int? minimumOrderAmount;
  final int? serviceCharge;
  final String? bkashNumber;

  PaymentSettings({
    this.acceptsCash,
    this.acceptsBkash,
    this.minimumOrderAmount,
    this.serviceCharge,
    this.bkashNumber,
  });

  factory PaymentSettings.fromJson(Map<String, dynamic> json) =>
      PaymentSettings(
        acceptsCash: json['acceptsCash'],
        acceptsBkash: json['acceptsBkash'],
        minimumOrderAmount: json['minimumOrderAmount'],
        serviceCharge: json['serviceCharge'],
        bkashNumber: json['bkashNumber'],
      );

  Map<String, dynamic> toJson() => {
        "acceptsCash": acceptsCash,
        "acceptsBkash": acceptsBkash,
        "minimumOrderAmount": minimumOrderAmount,
        "serviceCharge": serviceCharge,
        "bkashNumber": bkashNumber,
      };
}
