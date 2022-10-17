import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';
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
            height: 310.h,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.90),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 38.h),
              Center(
                child: Container(
                  width: 250.w,
                  child: Image.asset(
                    'assets/img/ilustration1.png',
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 6.w,
                      right: 6.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: CustomMenusCard(
                                icon: 'assets/icon/id-card.png',
                                title: 'Registrasi \ne-KTP',
                                height: 11.sp,
                                bottom: 14.h,
                                widthIcon: 36.w,
                                onTap: () => Get.toNamed(Routes.REKAMANAN_KTP),
                              ),
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/exchange.png',
                              title: 'Perubahan \ne-KTP',
                              height: 11.sp,
                              bottom: 12,
                              widthIcon: 38.w,
                              onTap: () {},
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/address.png',
                              title: 'Perpindahan\nKeluar',
                              height: 11.sp,
                              bottom: 12,
                              widthIcon: 38.w,
                              onTap: () {},
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
                              bottom: 6.h,
                              widthIcon: 34.w,
                              onTap: () {},
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/certificate.png',
                              title: 'Perubahan \ne-KTP',
                              height: 11.sp,
                              bottom: 12.h,
                              widthIcon: 37.w,
                              onTap: () {},
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/death-certificate.png',
                              title: 'Registrasi\nAkta Kematian',
                              height: 11.sp,
                              bottom: 13.h,
                              widthIcon: 32.w,
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 22.h),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 45.w, right: 47.w),
                              child: CustomMenusCard(
                                icon: 'assets/icon/update.png',
                                title: 'Perubahan \nKK',
                                height: 11.sp,
                                bottom: 12.h,
                                widthIcon: 36.w,
                                onTap: () {},
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
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          'Layanan Dukcapil',
          style: whiteTextStyle,
        ),
        actions: [],
      ),
      body: ListView(
        children: [
          backround(),
        ],
      ),
    );
  }
}
