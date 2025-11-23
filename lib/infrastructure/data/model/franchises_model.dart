import 'dart:convert';

class FranchisesModel {
  final int statusCode;
  final bool success;
  final String message;
  final List<Franchise> franchises;

  FranchisesModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.franchises,
  });

  /// Handles both list and map JSON responses
  factory FranchisesModel.fromJson(dynamic json) {
    if (json is List) {
      // API returns list directly
      return FranchisesModel(
        statusCode: 200,
        success: true,
        message: "Success",
        franchises: json.map((e) => Franchise.fromJson(e)).toList(),
      );
    } else if (json is Map<String, dynamic>) {
      // API returns a structured map
      final data = json['data'];

      // Handle when `data` might be a list directly
      final List<dynamic> rawFranchises =
      (data is List) ? data : (data?['franchises'] ?? []);

      return FranchisesModel(
        statusCode: json['statusCode'] ?? 200,
        success: json['success'] ?? true,
        message: json['message'] ?? 'Success',
        franchises:
        rawFranchises.map((e) => Franchise.fromJson(e)).toList(),
      );
    } else {
      throw ArgumentError(
          'Expected List or Map for FranchisesModel but got ${json.runtimeType}');
    }
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'success': success,
    'message': message,
    'franchises': franchises.map((x) => x.toJson()).toList(),
  };
}

class Franchise {
  final String id;
  final String name;
  final String code;
  final String? description;
  final Area? area;

  Franchise({
    required this.id,
    required this.name,
    required this.code,
    this.description,
    this.area,
  });

  factory Franchise.fromJson(Map<String, dynamic> json) => Franchise(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    code: json['code'] ?? '',
    description: json['description'],
    area: json['area'] != null ? Area.fromJson(json['area']) : null,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'code': code,
    if (description != null) 'description': description,
    if (area != null) 'area': area!.toJson(),
  };
}

class Area {
  final String? name;
  final String? division;
  final String? district;
  final String? thana;
  final String? city;
  final Coordinates? coordinates;
  final List<dynamic> postalCodes;

  Area({
    this.name,
    this.division,
    this.district,
    this.thana,
    this.city,
    this.coordinates,
    this.postalCodes = const [],
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    name: json['name'],
    division: json['division'],
    district: json['district'],
    thana: json['thana'],
    city: json['city'],
    coordinates: json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null,
    postalCodes: (json['postalCodes'] is List)
        ? List<dynamic>.from(json['postalCodes'])
        : const [],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'division': division,
    'district': district,
    'thana': thana,
    'city': city,
    if (coordinates != null) 'coordinates': coordinates!.toJson(),
    'postalCodes': postalCodes,
  };
}

class Coordinates {
  final String? type;
  final dynamic coordinates;

  Coordinates({
    this.type,
    this.coordinates,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    type: json['type'],
    coordinates: json['coordinates'],
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'coordinates': coordinates,
  };
}

