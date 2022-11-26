import 'package:get/get.dart';

import '../controllers/kartu_keluarga_controller.dart';

class KartuKeluargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KartuKeluargaController>(
      () => KartuKeluargaController(),
    );
  }
}
