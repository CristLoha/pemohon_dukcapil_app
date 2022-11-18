import 'package:get/get.dart';

import '../controllers/regis_akta_kematian_controller.dart';

class RegisAktaKematianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisAktaKematianController>(
      () => RegisAktaKematianController(),
    );
  }
}
