import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  final formKeys = GlobalKey<FormState>();

  void reset() async {
    try {
      await auth.sendPasswordResetEmail(email: emailC.text);
      Get.back();
      EasyLoading.showSuccess(
          'Kami telah mengirim tautan untuk menyetel ulang sandi email Anda.');
    } catch (e) {
      Get.snackbar("KESALAHAN TERJADI",
          "Tidak dapat menyetel ulang sandi ke email ini.");
    }
  }
}
