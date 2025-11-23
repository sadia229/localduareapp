class ShopMenuModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  ShopMenuModel({this.statusCode, this.success, this.message, this.data});

  ShopMenuModel.fromJson(Map<String, dynamic> json) {
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
  String? shop;
  String? name;
  String? description;
  List<Sections>? sections;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? id;

  Data(
      {this.sId,
      this.shop,
      this.name,
      this.description,
      this.sections,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.id,
      });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    shop = json['shop'];
    name = json['name'];
    description = json['description'];
    if (json['categories'] != null) {
      sections = <Sections>[];
      json['categories'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['shop'] = this.shop;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.sections != null) {
      data['categories'] = this.sections!.map((v) => v.toJson()).toList();
    }
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Sections {
  String? name;
  String? description;
  List<Items>? items;
  int? order;
  bool? isActive;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Sections(
      {this.name,
      this.description,
      this.items,
      this.order,
      this.isActive,
      this.sId,
      this.createdAt,
      this.updatedAt});

  Sections.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    order = json['order'];
    isActive = json['isActive'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['order'] = this.order;
    data['isActive'] = this.isActive;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Items {
  String? name;
  String? description;
  int? price;
  List<String>? images;
  bool? isAvailable;
  List<String>? dietaryInfo;
  String? preparationTime;
  String? sId;
  String? createdAt;
  String? updatedAt;
  String? id;

  Items(
      {this.name,
      this.description,
      this.price,
      this.images,
      this.isAvailable,
      this.dietaryInfo,
      this.preparationTime,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.id});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    images = json['images'].cast<String>();
    isAvailable = json['isAvailable'];
    dietaryInfo = json['dietaryInfo'].cast<String>();
    preparationTime = json['preparationTime'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['images'] = this.images;
    data['isAvailable'] = this.isAvailable;
    data['dietaryInfo'] = this.dietaryInfo;
    data['preparationTime'] = this.preparationTime;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
