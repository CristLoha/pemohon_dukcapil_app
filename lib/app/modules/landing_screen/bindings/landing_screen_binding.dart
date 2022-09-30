import 'package:get/get.dart';

import '../controllers/landing_screen_controller.dart';

class LandingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingScreenController>(
      () => LandingScreenController(),
    );
  }
}
