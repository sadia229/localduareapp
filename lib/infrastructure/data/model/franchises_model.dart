class FranchisesModel {
  int? statusCode;
  bool? success;
  String? message;
  List<Franchises>? data;

  FranchisesModel({this.statusCode, this.success, this.message, this.data});

  FranchisesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Franchises>[];
      json['data'].forEach((v) {
        data!.add(new Franchises.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Franchises {
  String? sId;
  String? name;
  String? code;
  String? description;
  Area? area;

  Franchises({
    this.sId,
    this.name,
    this.code,
    this.description,
    this.area,
  });

  Franchises.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
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
    return data;
  }
}

class Area {
  String? name;
  String? division;
  String? district;
  String? thana;
  String? city;
  List<Null>? postalCodes;

  Area({
    this.name,
    this.division,
    this.district,
    this.thana,
    this.city,
    this.postalCodes,
  });

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
