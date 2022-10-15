import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          print('Email belum terverifikasi & tidak dapat masuk');
          Get.defaultDialog(
            title: 'Belum terverifikasi',
            middleText: 'Apakah kamu ingin mengirim email verifikasi kembali?',
            actions: [
              OutlinedButton(
                onPressed: () => Get.back(),
                child: Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    print('Kirim ulang verifikasi');
                    await credential.user!.sendEmailVerification();
                    Get.back();
                    print('Berhasil mengirim email verifikasi');
                    Get.snackbar(
                      'Berhasil',
                      'Kami telah mengirim email verifikasi. Buka email kamu untuk tahap verifikasi',
                      backgroundColor: kBlackColor,
                      colorText: kWhiteColor,
                      snackPosition: SnackPosition.TOP,
                      isDismissible: true,
                      forwardAnimationCurve: Curves.easeOutBack,
                    );
                  } catch (e) {
                    Get.back();

                    Get.snackbar(
                      'Gagal',
                      'Kamu terlalu banyak meminta kirim email verifikasi',
                      backgroundColor: kBlackColor,
                      colorText: kWhiteColor,
                      snackPosition: SnackPosition.TOP,
                      isDismissible: true,
                      forwardAnimationCurve: Curves.easeOutBack,
                    );
                  }
                },
                child: Text('Kirim Lagi'),
              )
            ],
          );
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
