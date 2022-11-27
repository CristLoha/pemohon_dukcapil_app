import 'package:get/get.dart';

import '../controllers/akta_nikah_controller.dart';

class AktaNikahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AktaNikahController>(
      () => AktaNikahController(),
    );
  }
}
