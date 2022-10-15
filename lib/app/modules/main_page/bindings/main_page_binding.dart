import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/modules/settings/controllers/settings_controller.dart';

import '../controllers/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(
      () => MainPageController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
  }
}
