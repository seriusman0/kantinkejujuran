import 'package:get/get.dart';

import '../controllers/get_barang_controller.dart';

class GetBarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetBarangController>(
      () => GetBarangController(),
    );
  }
}
