import 'package:get/get.dart';

import '../controllers/edit_dokumen_controller.dart';

class EditDokumenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditDokumenController>(
      () => EditDokumenController(),
    );
  }
}
