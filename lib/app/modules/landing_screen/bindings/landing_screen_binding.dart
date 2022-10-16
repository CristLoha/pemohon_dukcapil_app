import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/modules/main_page/controllers/main_page_controller.dart';

import '../controllers/landing_screen_controller.dart';

class LandingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingScreenController>(
      () => LandingScreenController(),
    );

    Get.lazyPut<MainPageController>(
      () => MainPageController(),
    );
  }
}
