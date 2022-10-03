import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

import '../../../utils/custom_menus_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Widget backround() {
      return Stack(
        children: [
          Container(
            height: 320.h,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.90),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 220.h, left: 20.w, right: 20.w),
            child: Card(
              elevation: 1,
              child: Center(
                child: Container(
                  width: 340.w,
                  height: Get.height * 0.49,
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 27.h, left: 6.w, right: 6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomMenusCard(
                              icon: 'assets/icon/id-card.png',
                              title: 'Registrasi \ne-KTP',
                              height: 11.sp,
                              bottom: 18.h,
                              widthIcon: 38.w,
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/exchange.png',
                              title: 'Perubahan \ne-KTP',
                              height: 11.sp,
                              bottom: 12,
                              widthIcon: 38.w,
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/address.png',
                              title: 'Perpindahan\nKeluar',
                              height: 11.sp,
                              bottom: 12,
                              widthIcon: 38.w,
                            ),
                          ],
                        ),
                        SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomMenusCard(
                              icon: 'assets/icon/card-birth.png',
                              title: 'Registrasi \nAkta Kelahiran',
                              height: 11.sp,
                              bottom: 7.h,
                              widthIcon: 36.w,
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/certificate.png',
                              title: 'Perubahan \ne-KTP',
                              height: 11.sp,
                              bottom: 12.h,
                              widthIcon: 37.w,
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/death-certificate.png',
                              title: 'Registrasi\nAkta Kematian',
                              height: 11.sp,
                              bottom: 13.h,
                              widthIcon: 32.w,
                            ),
                          ],
                        ),
                        SizedBox(height: 22.h),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 30.w, right: 30.w),
                              child: CustomMenusCard(
                                icon: 'assets/icon/update.png',
                                title: 'Perubahan \nKK',
                                height: 11.sp,
                                bottom: 12.h,
                                widthIcon: 36.w,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: CustomMenusCard(
                                icon: 'assets/icon/id_kia.png',
                                title: 'Registrasi \nKIA',
                                height: 11.sp,
                                bottom: 15.h,
                                widthIcon: 39.w,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          backround(),
        ],
      ),
    );
  }
}
