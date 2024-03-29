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
            height: 260.h,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.90),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Container(
                  width: 227.w,
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
                              padding: EdgeInsets.only(
                                top: 7.h,
                                left: 5.w,
                              ),
                              child: CustomMenusCard(
                                icon: 'assets/icon/id-card.png',
                                title: 'Perekaman\ne-KTP',
                                height: 11.sp,
                                bottom: 14.h,
                                widthIcon: 36.w,
                                onTap: () => Get.toNamed(Routes.REKAMANAN_KTP),
                              ),
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/exchange.png',
                              title: 'Penggantian\ne-KTP',
                              height: 11.sp,
                              bottom: 12,
                              widthIcon: 38.w,
                              onTap: () {
                                Get.toNamed(Routes.PERUBAHAN_KTP);
                              },
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/house.png',
                              title: 'Permohonan\nPindah Datang',
                              height: 11.sp,
                              bottom: 12,
                              widthIcon: 38.w,
                              onTap: () {
                                Get.toNamed(Routes.SURAT_KETERANGAN_PINDAH);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomMenusCard(
                              icon: 'assets/icon/card-birth.png',
                              title: 'Akta\nKelahiran',
                              height: 11.sp,
                              bottom: 6.h,
                              widthIcon: 34.w,
                              onTap: () {
                                Get.toNamed(Routes.AKTA_KELAHIRAN);
                              },
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/marriage-certificate.png',
                              title: 'Akta\nNikah',
                              height: 11.sp,
                              bottom: 12.h,
                              widthIcon: 37.w,
                              onTap: () {
                                Get.toNamed(Routes.AKTA_NIKAH);
                              },
                            ),
                            CustomMenusCard(
                              icon: 'assets/icon/death-certificate.png',
                              title: 'Akta\nKematian',
                              height: 11.sp,
                              bottom: 13.h,
                              widthIcon: 32.w,
                              onTap: () {
                                Get.toNamed(Routes.REGIS_AKTA_KEMATIAN);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 22.h),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 45.w),
                              child: CustomMenusCard(
                                icon: 'assets/icon/id_kia.png',
                                title: 'Kartu Identitas\nAnak',
                                height: 11.sp,
                                bottom: 12.h,
                                widthIcon: 36.w,
                                onTap: () {
                                  Get.toNamed(Routes.REGIST_KIA);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 100.h),
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
