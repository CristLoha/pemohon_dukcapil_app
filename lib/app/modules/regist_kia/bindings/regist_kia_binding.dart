import 'package:get/get.dart';

import '../controllers/regist_kia_controller.dart';

class RegistKiaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistKiaController>(
      () => RegistKiaController(),
    );
  }
}
