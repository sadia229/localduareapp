import 'package:get/get.dart';

class SelectAddressController extends GetxController {
  final areaName = ''.obs;
  final selectedArea = 'Area 1'.obs;
  final  areaList = [].obs;

  void onAreaNameChanged(String value) {
    areaName.value = value;
  }

  void onAreaListChanged(List<String> value) {
    areaList.value = value;
  }
  @override
  void onInit() {
    super.onInit();
  }
}
