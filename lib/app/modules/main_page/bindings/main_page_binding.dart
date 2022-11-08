import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/modules/history/controllers/history_controller.dart';
import '../controllers/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(
      () => MainPageController(),
    );

    Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
  }
}
