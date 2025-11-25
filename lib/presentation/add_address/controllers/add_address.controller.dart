import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/static/project.constants.dart';
import '../../cart/controllers/cart.controller.dart';
import '../../get_delivery_address/controllers/get_delivery_address.controller.dart';

class Coordinates {
  final String? type;
  final List<List<List<double>>>? coordinates; // Polygon coordinates

  Coordinates({this.type, this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    final raw = json['coordinates'] as List<dynamic>?;
    List<List<List<double>>>? coords;

    if (raw != null) {
      coords = raw
          .map((outer) => (outer as List<dynamic>)
              .map((inner) => (inner as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList())
              .toList())
          .toList();
    }

    return Coordinates(
      type: json['type'] as String?,
      coordinates: coords,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };
}

class AddAddressController extends GetxController with WidgetsBindingObserver {
  final isLoading = true.obs;
  final currentPosition = Rxn<Position>();
  final currentLatLng = Rxn<LatLng>();
  final mapController = Rxn<GoogleMapController>();

  final marker = Rxn<Marker>();

  final addressText = ''.obs;
  final textFieldAddressText = ''.obs;
  final latText = ''.obs;
  final lngText = ''.obs;

  final doubleLatText = 0.0.obs;
  final doubleLngText = 0.0.obs;

  final street = ''.obs;
  final name = ''.obs;
  final thoroughfare = ''.obs;
  final locality = ''.obs;
  final postalCode = ''.obs;
  final country = ''.obs;
  final isoCountryCode = ''.obs;

  final Set<Polygon> _polygons = HashSet<Polygon>();

  // expose polygons set if needed
  Set<Polygon> get polygons => _polygons;

  // Provide 'polygon' getter because existing UI uses ctrl.polygon
  List<LatLng> get polygon => _points;

  final Completer<GoogleMapController> _controller = Completer();
  final titleController = TextEditingController();
  final apartmentController = TextEditingController();
  final defaultAddress = false.obs;
  final isFromCart = false.obs;
  final insidePolygon = false.obs;

  final List<LatLng> _points = <LatLng>[].obs;

  @override
  void onInit() {
    super.onInit();
    isFromCart.value = Get.arguments['isFromCart'] ?? false;
    debugPrint("print isFromCart:${isFromCart.value}");
    WidgetsBinding.instance.addObserver(this);
    _initPolygon();
    _determinePosition();
    loadSavedPolygon();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _determinePosition();
  }

  Future<Coordinates?> getSavedCoordinates() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('coordinates');

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return Coordinates.fromJson(jsonMap);
    }
    return null;
  }

  Future<void> loadSavedPolygon() async {
    final coords = await getSavedCoordinates();
    if (coords != null && coords.coordinates != null) {
      // Assuming it's a polygon: first list is the outer polygon
      final outerPolygon = coords.coordinates!.first;

      _points.clear();
      for (var point in outerPolygon) {
        // point[1] = latitude, point[0] = longitude (GeoJSON format)
        _points.add(LatLng(point[1], point[0]));
      }

      debugPrint("Loaded ${_points.length} points from saved coordinates");
      for (var point in _points) {
        debugPrint("Pointxxxx: $point");
        debugPrint("Pointxxxx: ");
      }
    }
  }

  Future<void> _determinePosition() async {
    isLoading.value = true;
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        _showLocationDisabledDialog();
        isLoading.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isLoading.value = false;
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        isLoading.value = false;
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition.value = pos;
      debugPrint("baler Position: ${pos.latitude}, ${pos.longitude}");
      currentLatLng.value = LatLng(pos.latitude, pos.longitude);

      setMarker(currentLatLng.value!, draggable: false);
      updateSelectedInfo(currentLatLng.value!);
      _animateTo(currentLatLng.value!);
    } catch (e) {
      debugPrint('Error obtaining location: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _initPolygon() {
    _polygons.add(
      Polygon(
        polygonId: const PolygonId('allowed_area'),
        points: _points,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      ),
    );
  }

  /// Simple ray-casting algorithm to determine if a point is inside polygon.
  // bool pointInPolygon(LatLng point) {
  //   bool inside = false;
  //   for (int i = 0, j = _points.length - 1; i < _points.length; j = i++) {
  //     final xi = _points[i].latitude, yi = _points[i].longitude;
  //     final xj = _points[j].latitude, yj = _points[j].longitude;
  //
  //     final intersect = ((yi > point.longitude) != (yj > point.longitude)) &&
  //         (point.latitude <
  //             (xj - xi) *
  //                 (point.longitude - yi) /
  //                 ((yj - yi) == 0 ? 1e-12 : (yj - yi)) +
  //                 xi);
  //     if (intersect) inside = !inside;
  //   }
  //   return inside;
  // }

  bool pointInPolygon(LatLng point) {
    final x = point.longitude;
    // final x = doubleLngText.value;
    final y = point.latitude;
    // final y = doubleLatText.value;

    debugPrint(
        "✅ Selected location inside polygon longitude, latitude: $x, $y, ${x.runtimeType} , ${y.runtimeType}");
    bool inside = false;

    for (int i = 0, j = _points.length - 1; i < _points.length; j = i++) {
      final xi = _points[i].longitude;
      final yi = _points[i].latitude;
      final xj = _points[j].longitude;
      final yj = _points[j].latitude;

      final intersects = ((yi > y) != (yj > y)) &&
          (x <
              (xj - xi) *
                      (y - yi) /
                      ((yj - yi).abs() < 1e-12 ? 1e-12 : (yj - yi)) +
                  xi);

      if (intersects) inside = !inside;
    }
    debugPrint("✅ Sadia inside: $inside");
    return inside;
  }

  void setMarker(LatLng pos, {bool draggable = false}) {
    marker.value = Marker(
      markerId: const MarkerId('selectedMarker'),
      position: pos,
      draggable: draggable,
      onDragEnd: (newPos) async {
        // only allow dragging inside polygon
        if (pointInPolygon(newPos)) {
          updateSelectedInfo(newPos);
          final addr = await reverseGeocode(newPos);
          addressText.value = addr ?? '';
          // update currentLatLng to reflect new marker position
          currentLatLng.value = newPos;
          await _updateSelectedDeliveryAddress(newPos, addr);
        } else {
          //Get.snackbar('Out of Area', 'Keep marker inside the allowed area.',
          //snackPosition: SnackPosition.BOTTOM);
          // Snap back to previous (marker.value may still hold previous pos)
          if (marker.value != null) {
            setMarker(marker.value!.position, draggable: true);
          }
        }
      },
    );

    // animate map camera to marker if controller is available
    _animateTo(pos);
  }

  Future<void> updateSelectedInfo(LatLng pos) async {
    latText.value = pos.latitude.toStringAsFixed(6);
    lngText.value = pos.longitude.toStringAsFixed(6);
    doubleLatText.value = pos.latitude;
    doubleLngText.value = pos.longitude;
    debugPrint(
        "✅ Update Selected Info longitude, latitude: ${pos.longitude}, ${pos.latitude}");
    currentLatLng.value = pos;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('order_updated_lat', pos.latitude);
    prefs.setDouble('order_updated_lng', pos.longitude);
  }

  Future<String?> reverseGeocode(LatLng pos) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isEmpty) return null;
      final p = placemarks.first;

      street.value = p.street ?? '';
      name.value = p.name ?? '';
      thoroughfare.value = p.thoroughfare ?? '';
      locality.value = p.locality ?? '';
      postalCode.value = p.postalCode ?? '';
      country.value = p.country ?? '';
      isoCountryCode.value = p.isoCountryCode ?? '';

      final components = [
        if (p.street?.isNotEmpty ?? false) p.street,
        if (p.subLocality?.isNotEmpty ?? false) p.subLocality,
        if (p.locality?.isNotEmpty ?? false) p.locality,
        if (p.administrativeArea?.isNotEmpty ?? false) p.administrativeArea,
        if (p.postalCode?.isNotEmpty ?? false) p.postalCode,
      ].join(', ');

      textFieldAddressText.value =
          components.isEmpty ? p.name ?? '' : components;
      apartmentController.text =
          components.isEmpty ? 'Enter Apartment Number' : components;
      street.value = p.street ?? '';
      name.value = p.name ?? '';
      thoroughfare.value = p.thoroughfare ?? '';
      locality.value = p.locality ?? '';
      postalCode.value = p.postalCode ?? '';
      country.value = p.country ?? '';
      isoCountryCode.value = p.isoCountryCode ?? '';
      debugPrint('myxxxxxx street: ${street.value}');
      debugPrint('myxxxxxx name: ${name.value}');
      debugPrint('myxxxxxx thoroughfare: ${thoroughfare.value}');
      debugPrint('myxxxxxx locality: ${locality.value}');
      debugPrint('myxxxxxx postalCode: ${postalCode.value}');
      debugPrint('myxxxxxx country: ${country.value}');
      debugPrint('myxxxxxx isoCountryCode: ${isoCountryCode.value}');
      final prefs = await SharedPreferences.getInstance();
      final localLatitude = prefs.getDouble('order_updated_lat');
      final localLongitude = prefs.getDouble('order_updated_lng');
      debugPrint('myxxxxxx localLatitude: ${localLatitude}');
      debugPrint('myxxxxxx localLongitude: ${localLongitude}');

      final deliveryAddress = {
        "type": titleController.text ?? "",
        "label": titleController.text ?? "",
        "street": street.value ?? "",
        "area": "${name.value ?? ""}, ${thoroughfare.value ?? ""}",
        "city": locality.value ?? "",
        "district": country.value ?? "",
        "landmark": country.value ?? "",
        "phone": "01721530226",
        "coordinates": {
          "type": "Point",
          "coordinates": [
            localLatitude ?? 0.0,
            localLongitude ?? 0.0,
          ],
        },
      };

      await prefs.setString(
        'selected_delivery_address',
        jsonEncode(deliveryAddress),
      );

      debugPrint("myxxxxxx Saved delivery address: $deliveryAddress");

      return components.isEmpty ? p.name ?? '' : components;
    } catch (e) {
      debugPrint('Reverse geocode failed: $e');
      return null;
    }
  }

  Future<void> onAddLocationPressed() async {
    final cur = currentLatLng.value;
    if (cur == null) {
      Get.snackbar('Error', 'Current location not found.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (pointInPolygon(cur)) {
      await _saveSelectedLocation(cur, await reverseGeocode(cur));
      await _updateSelectedDeliveryAddress(cur, await reverseGeocode(cur));
      debugPrint("✅ Sadia inside polygon: ${cur.latitude}, ${cur.longitude}");
      Get.find<CartController>().getDeliveryCharge();
      Get.offAllNamed(Routes.CART);
    } else {
      debugPrint(
          'Selected location outside polygon: ${cur.latitude}, ${cur.longitude}');
      setMarker(cur, draggable: true);
      final center = _getPolygonCenter();
      _animateTo(center);
    }
  }

  Future<void> _saveSelectedLocation(LatLng pos, String? address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('selected_lat', pos.latitude);
    await prefs.setDouble('selected_lng', pos.longitude);
    if (address != null) await prefs.setString('selected_address', address);
    debugPrint("Selected location saved: $pos, $address");
    debugPrint("lat: ${pos.latitude}, lng: ${pos.longitude}");
    debugPrint("address: $address");
  }

  Future<void> _updateSelectedDeliveryAddress(
      LatLng pos, String? address) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final deliveryAddress = {
        "type": "home",
        "label": "Home",
        "street": street.value,
        "area": locality.value,
        "city": locality.value,
        "district": country.value,
        "landmark": address ?? "",
        "phone": "",
        "coordinates": {
          "type": "Point",
          "coordinates": [pos.longitude, pos.latitude],
        },
      };

      await prefs.setString(
        'selected_delivery_address',
        jsonEncode(deliveryAddress),
      );

      debugPrint("✅ Updated selected_delivery_address: $deliveryAddress");
    } catch (e) {
      debugPrint("❌ Failed to update selected_delivery_address: $e");
    }
  }

  void _showLocationDisabledDialog() {
    Get.defaultDialog(
      title: 'Location Disabled',
      middleText: 'Please enable location services.',
      textConfirm: 'Open Settings',
      onConfirm: () async {
        await Geolocator.openLocationSettings();
        Get.back();
      },
      textCancel: 'Cancel',
    );
  }

  void toggleDefaultAddress(bool value) => defaultAddress.value = value;

  Future<void> saveMarkerLocation() async {
    final m = marker.value;
    if (m == null) return;
    final pos = m.position;
    final addr = await reverseGeocode(pos);
    await _saveSelectedLocation(pos, addr);
    Get.snackbar(
      'Saved',
      'Selected location saved.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  LatLng _getPolygonCenter() {
    double lat = 0, lng = 0;
    for (var p in _points) {
      lat += p.latitude;
      lng += p.longitude;
    }
    return LatLng(lat / _points.length, lng / _points.length);
  }

  Future<void> _animateTo(LatLng pos) async {
    try {
      final gmc = mapController.value;
      if (gmc != null) {
        await gmc.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: pos, zoom: 11)));
      }
    } catch (e) {
      // Ignore animate errors
      debugPrint('Animate camera failed: $e');
    }
  }
}
