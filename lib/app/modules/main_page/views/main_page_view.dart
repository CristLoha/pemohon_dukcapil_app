import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/modules/history/views/history_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/profile/views/profile_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/settings/views/settings_view.dart';

import '../../../utils/bottom_bar.dart';
import '../../home/views/home_view.dart';
import '../controllers/main_page_controller.dart';

class MainPageView extends GetView<MainPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            controller.selected.value == ButtonIcons.home
                ? HomeView()
                : Container(),
            controller.selected.value == ButtonIcons.history
                ? HistoryView()
                : Container(),
            controller.selected.value == ButtonIcons.profile
                ? ProfileView()
                : Container(),
            controller.selected.value == ButtonIcons.settings
                ? SettingsView()
                : Container(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// HOME
                    BottomBar(
                      onPressed: () => controller.homeButton(),
                      bottomIcons: controller.selected.value == ButtonIcons.home
                          ? true
                          : false,
                      icons: EvaIcons.home,
                      text: "Beranda",
                      icons2: EvaIcons.home,
                    ),

                    /// HISTORY
                    BottomBar(
                      onPressed: () => controller.historyButton(),
                      bottomIcons:
                          controller.selected.value == ButtonIcons.history
                              ? true
                              : false,
                      icons: EvaIcons.fileTextOutline,
                      text: 'Riwayat',
                      icons2: EvaIcons.fileTextOutline,
                    ),

                    /// PROFILE
                    BottomBar(
                      onPressed: () => controller.chatButton(),
                      bottomIcons:
                          controller.selected.value == ButtonIcons.profile
                              ? true
                              : false,
                      icons: EvaIcons.personOutline,
                      text: 'Profil',
                      icons2: EvaIcons.personOutline,
                    ),

                    /// SETTINGS
                    BottomBar(
                      onPressed: () => controller.settingsButton(),
                      bottomIcons:
                          controller.selected.value == ButtonIcons.settings
                              ? true
                              : false,
                      icons: EvaIcons.settingsOutline,
                      text: 'Pengaturan',
                      icons2: EvaIcons.settingsOutline,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
