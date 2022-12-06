import 'package:get/get.dart';

import '../controllers/surat_keterangan_pindah_controller.dart';

class SuratKeteranganPindahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratKeteranganPindahController>(
      () => SuratKeteranganPindahController(),
    );
  }
}
