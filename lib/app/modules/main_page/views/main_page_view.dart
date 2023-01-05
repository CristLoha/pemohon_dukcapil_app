import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/modules/history/views/history_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/home/views/home_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/main_page/controllers/main_page_controller.dart';
import 'package:pemohon_dukcapil_app/app/modules/settings/views/settings_view.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPageView extends StatefulWidget {
  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  final controller = Get.put(MainPageController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
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
      bottomNavigationBar: BottomNavyBar(
        iconSize: 30.h,
        containerHeight: 54.h,
        itemCornerRadius: 30,
        showElevation: true,
        items: [
          BottomNavyBarItem(
              activeColor: kPrimaryColor,
              title: Text('Beranda'),
              icon: Icon(
                Icons.home,
              )),
          BottomNavyBarItem(
              activeColor: kPrimaryColor,
              title: Text('Riwayat'),
              icon: Icon(
                Icons.description_outlined,
              )),
          BottomNavyBarItem(
              activeColor: kPrimaryColor,
              title: Text('Pengaturan'),
              icon: Icon(
                Icons.settings,
              )),
        ],
        selectedIndex: controller.currentIndex.value,
        onItemSelected: (index) {
          setState(() => controller.currentIndex.value = index);
          controller.pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
      ),
    );
  }
}
