import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

class LoginController extends GetxController {
  final formKeys = GlobalKey<FormState>();

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

  FirebaseAuth auth = FirebaseAuth.instance;
  void login() async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );

      print(credential);

      if (credential.user!.emailVerified == true) {
        EasyLoading.showSuccess('Berhasil masuk');
        Get.offAllNamed(Routes.LANDING_SCREEN);
      } else {
        print('Email belum terverifikasi & tidak dapat masuk');
        await EasyLoading.dismiss();
        Get.defaultDialog(
          title: 'Belum terverifikasi',
          middleText: 'Apakah Anda ingin mengirim ulang email verifikasi?',
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
                    'Kami telah mengirim email verifikasi. Buka email Anda untuk tahap verifikasi',
                  );
                } catch (e) {
                  Get.back();
                  infoMsg('KESALAHAN TERJADI',
                      'Anda telah terlalu sering meminta pengiriman ulang email verifikasi.');
                  ;
                }
              },
              child: Text('Kirim Ulang'),
            )
          ],
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        infoMsg('KESALAHAN TERJADI', 'Pengguna tidak ditemukan');
        EasyLoading.dismiss();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        infoMsg('KESALAHAN TERJADI', 'Sandi salah');
        EasyLoading.dismiss();
        print('Wrong password provided for that user.');
      }
    }
  }
}
