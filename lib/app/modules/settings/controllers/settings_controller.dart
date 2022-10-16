import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';

import '../../../shared/theme.dart';

class SettingsController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar(
        'TERJADI KESALAHAN',
        'Tidak dapat keluar',
        backgroundColor: kBlackColor,
        colorText: kWhiteColor,
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print(e);
    }
  }
}
