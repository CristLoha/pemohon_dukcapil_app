import 'package:get/get.dart';

import '../controllers/rekamanan_ktp_controller.dart';

class RekamananKtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RekamananKtpController>(
      () => RekamananKtpController(),
    );
  }
}
