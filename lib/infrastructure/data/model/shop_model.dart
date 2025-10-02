class ShopModel {
  int? statusCode;
  bool? success;
  String? message;
  List<Shop>? data;
  Meta? meta;

  ShopModel(
      {this.statusCode, this.success, this.message, this.data, this.meta});

  ShopModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Shop>[];
      json['data'].forEach((v) {
        data!.add(new Shop.fromJson(v));
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

class Shop {
  String? sId;
  String? shopId;
  String? name;
  String? description;
  Franchise? franchise;
  Images? images;

  Shop({
    this.sId,
    this.shopId,
    this.name,
    this.description,
    this.franchise,
    this.images,
  });

  Shop.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    shopId = json['shopId'];
    name = json['name'];
    description = json['description'];
    franchise = json['franchise'] != null
        ? new Franchise.fromJson(json['franchise'])
        : null;
    images =
        json['images'] != null ? new Images.fromJson(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['shopId'] = this.shopId;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.franchise != null) {
      data['franchise'] = this.franchise!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    return data;
  }
}

class Franchise {
  String? sId;
  String? name;
  String? code;
  String? description;
  Area? area;
  String? ownerId;
  String? status;
  ContactInfo? contactInfo;

  Franchise({
    this.sId,
    this.name,
    this.code,
    this.description,
    this.area,
    this.ownerId,
    this.status,
    this.contactInfo,
  });

  Franchise.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
    ownerId = json['ownerId'];
    status = json['status'];
    contactInfo = json['contactInfo'] != null
        ? new ContactInfo.fromJson(json['contactInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    data['ownerId'] = this.ownerId;
    data['status'] = this.status;
    if (this.contactInfo != null) {
      data['contactInfo'] = this.contactInfo!.toJson();
    }
    return data;
  }
}

class Area {
  String? name;
  String? division;
  String? district;
  String? thana;
  String? city;

  Area({this.name, this.division, this.district, this.thana, this.city});

  Area.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    division = json['division'];
    district = json['district'];
    thana = json['thana'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['division'] = this.division;
    data['district'] = this.district;
    data['thana'] = this.thana;
    data['city'] = this.city;
    return data;
  }
}

class ContactInfo {
  String? email;
  String? phone;
  String? address;
  String? emergencyContact;

  ContactInfo({this.email, this.phone, this.address, this.emergencyContact});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    emergencyContact = json['emergencyContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['emergencyContact'] = this.emergencyContact;
    return data;
  }
}

class Images {
  String? logo;
  String? banner;
  List<String>? gallery;

  Images({this.logo, this.banner, this.gallery});

  Images.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    banner = json['banner'];
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    data['gallery'] = this.gallery;
    return data;
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['totalPages'] = this.totalPages;
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    return data;
  }
}
