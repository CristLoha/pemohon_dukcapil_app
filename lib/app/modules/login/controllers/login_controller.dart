import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

class LoginController extends GetxController {
  Timer? timer;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isHidden = false.obs;
  RxBool isSelected = false.obs;
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        UserCredential credential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        print(credential);
        isLoading.value = false;

        if (credential.user!.emailVerified == true) {
          Get.offAllNamed(Routes.MAIN_PAGE);
        } else {
          Get.snackbar(
            'Peringatan',
            'Email belum terverifikasi',
            backgroundColor: kBlackColor,
            colorText: kWhiteColor,
            snackPosition: SnackPosition.TOP,
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
          print('Email belum terverifikasi & tidak dapat masuk');
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar(
            'Peringatan',
            'Pengguna tidak ditemukan',
            backgroundColor: kBlackColor,
            colorText: kWhiteColor,
            snackPosition: SnackPosition.TOP,
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
            'Peringatan',
            'Kata sandi salah',
            backgroundColor: kBlackColor,
            colorText: kWhiteColor,
            snackPosition: SnackPosition.TOP,
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
