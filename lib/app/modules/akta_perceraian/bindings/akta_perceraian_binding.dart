import 'package:get/get.dart';

import '../controllers/akta_perceraian_controller.dart';

class AktaPerceraianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AktaPerceraianController>(
      () => AktaPerceraianController(),
    );
  }
}
