import 'package:get/get.dart';

import '../controllers/akta_kelahiran_controller.dart';

class AktaKelahiranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AktaKelahiranController>(
      () => AktaKelahiranController(),
    );
  }
}
