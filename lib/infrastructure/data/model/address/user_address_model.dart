class UserAddressModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  UserAddressModel({this.statusCode, this.success, this.message, this.data});

  UserAddressModel.fromJson(Map<String, dynamic> json) {
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
  List<Addresses>? addresses;
  int? defaultAddressIndex;

  Data({this.addresses, this.defaultAddressIndex});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
    defaultAddressIndex = json['defaultAddressIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['defaultAddressIndex'] = this.defaultAddressIndex;
    return data;
  }
}

class Addresses {
  Coordinates? coordinates;
  String? type;
  String? label;
  String? street;
  String? area;
  String? city;
  String? district;
  String? postalCode;
  String? landmark;
  String? phone;
  String? sId;

  Addresses(
      {this.coordinates,
      this.type,
      this.label,
      this.street,
      this.area,
      this.city,
      this.district,
      this.postalCode,
      this.landmark,
      this.phone,
      this.sId});

  Addresses.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
    type = json['type'];
    label = json['label'];
    street = json['street'];
    area = json['area'];
    city = json['city'];
    district = json['district'];
    postalCode = json['postalCode'];
    landmark = json['landmark'];
    phone = json['phone'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    data['type'] = this.type;
    data['label'] = this.label;
    data['street'] = this.street;
    data['area'] = this.area;
    data['city'] = this.city;
    data['district'] = this.district;
    data['postalCode'] = this.postalCode;
    data['landmark'] = this.landmark;
    data['phone'] = this.phone;
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
