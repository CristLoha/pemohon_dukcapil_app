import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/modules/history/views/history_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/home/views/home_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/settings/views/settings_view.dart';
import '../controllers/main_page_controller.dart';

class MainPageView extends GetView<MainPageController> {
  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: ScrollPhysics(
            parent: NeverScrollableScrollPhysics(),
          ),
          children: [
            Container(
              child: Center(
                child: HomeView(),
              ),
            ),
            Container(
              child: Center(
                child: HistoryView(),
              ),
            ),
            Container(
              child: Center(
                child: SettingsView(),
              ),
            ),
          ],
          controller: controller.pageController,
        ),
      ),
      bottomNavigationBar: Obx(
        () => FancyBottomNavigation(
          tabs: [
            TabData(iconData: EvaIcons.home, title: "Beranda"),
            TabData(iconData: EvaIcons.fileTextOutline, title: "Riwayat"),
            TabData(iconData: EvaIcons.settingsOutline, title: "Pengaturan"),
          ],
          onTabChangedListener: (position) {
            controller.currentIndex.value = position;
            controller.pageController.jumpToPage(position);
          },
          initialSelection: controller.currentIndex.value,
          key: controller.bottomNavigationKey,
        ),
      ),
    );
  }
}
