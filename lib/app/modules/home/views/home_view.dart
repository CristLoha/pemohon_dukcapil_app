import 'package:flutter/material.dart';
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
            height: Get.height * 0.30,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.90),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 320),
            child: Center(
              child: Container(
                width: Get.width * 0.90,
                height: Get.height * 0.30,
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CustomMenusCard(
                            padding: EdgeInsets.all(0),
                            icon: 'assets/icon/id-card.png',
                            title: 'Registrasi \ne-KTP',
                            height: 11,
                            widthIcon: Get.width * 0.10,
                          ),
                          CustomMenusCard(
                            padding: EdgeInsets.only(left: 20),
                            icon: 'assets/icon/exchange.png',
                            title: 'Perubahan \ne-KTP',
                            height: 11,
                            widthIcon: 30,
                          ),
                          CustomMenusCard(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            icon: 'assets/icon/address.png',
                            title: 'Perpindahan\nKeluar',
                            height: 11,
                            widthIcon: Get.width * 0.10,
                          ),
                          CustomMenusCard(
                            padding: EdgeInsets.all(0),
                            icon: 'assets/icon/id_kia.png',
                            title: 'Registrasi \nKIA',
                            height: 11,
                            widthIcon: Get.width * 0.10,
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      Row(
                        children: [
                          CustomMenusCard(
                            padding: EdgeInsets.all(0),
                            icon: 'assets/icon/card-birth.png',
                            title: 'Registrasi \nAkta Kelahiran',
                            height: 11,
                            widthIcon: Get.width * 0.10,
                          ),
                          CustomMenusCard(
                            padding: EdgeInsets.only(left: 10),
                            icon: 'assets/icon/certificate.png',
                            title: 'Perubahan \ne-KTP',
                            height: 11,
                            widthIcon: Get.width * 0.10,
                          ),
                          CustomMenusCard(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            icon: 'assets/icon/death-certificate.png',
                            title: 'Perpindahan\nKeluar',
                            height: 11,
                            widthIcon: Get.width * 0.10,
                          ),
                          CustomMenusCard(
                            padding: EdgeInsets.all(0),
                            icon: 'assets/icon/update.png',
                            title: 'Registrasi \nKIA',
                            height: 11,
                            widthIcon: Get.width * 0.10,
                          ),
                        ],
                      )
                    ],
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
