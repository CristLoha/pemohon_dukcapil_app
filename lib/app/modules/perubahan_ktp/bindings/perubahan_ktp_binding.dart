import 'package:get/get.dart';

import '../controllers/perubahan_ktp_controller.dart';

class PerubahanKtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerubahanKtpController>(
      () => PerubahanKtpController(),
    );
  }
}
