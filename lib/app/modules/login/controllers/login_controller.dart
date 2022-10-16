import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

class LoginController extends GetxController {
  void infoMsg(String msg1, String msg2) {
    Get.snackbar(
      msg1,
      msg2,
      backgroundColor: kBlackColor,
      colorText: kWhiteColor,
      snackPosition: SnackPosition.TOP,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

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
          Get.offAllNamed(Routes.LANDING_SCREEN);
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
                    infoMsg(
                      'BERHASIL',
                      'Kami telah mengirim email verifikasi. Buka email kamu untuk tahap verifikasi',
                    );
                  } catch (e) {
                    Get.back();
                    infoMsg('TERJADI KESALAHAN',
                        'Kamu terlalu banyak meminta kirim email verifikasi');
                  }
                  infoMsg(
                    'TERJADI KESALAHAN',
                    'Kamu terlalu banyak meminta kirim email verifikasi',
                  );
                },
                child: Text('Kirim Lagi'),
              )
            ],
          );
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          infoMsg('TERJADI KESALAHAN', 'Pengguna tidak ditemukan');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          infoMsg('TERJADI KESALAHAN', 'Kata sandi salah');
          print('Wrong password provided for that user.');
        }
      }
    } else {
      infoMsg('TERJADI KESALAHAN', 'Email atau kata sandi harus diisi');
    }
  }
}
