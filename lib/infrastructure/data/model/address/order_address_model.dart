class OrderAddressModel {
  final String? type;
  final String? label;
  final String? street;
  final String? area;
  final String? city;
  final String? district;
  final String? landmark;
  final String? phone;
  final Coordinates? coordinates;
  final bool? isDefault;

  OrderAddressModel({
    this.type,
    this.label,
    this.street,
    this.area,
    this.city,
    this.district,
    this.landmark,
    this.phone,
    this.coordinates,
    this.isDefault,
  });

  factory OrderAddressModel.fromJson(Map<String, dynamic> json) {
    return OrderAddressModel(
      type: json['type'],
      label: json['label'],
      street: json['street'],
      area: json['area'],
      city: json['city'],
      district: json['district'],
      landmark: json['landmark'],
      phone: json['phone'],
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : null,
      isDefault: json['isDefault'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'label': label,
      'street': street,
      'area': area,
      'city': city,
      'district': district,
      'landmark': landmark,
      'phone': phone,
      'coordinates': coordinates?.toJson(),
      'isDefault': isDefault,
    };
  }
}

class Coordinates {
  final String? type;
  final List<double>? coordinates;

  Coordinates({this.type, this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'].map((x) => x.toDouble()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
