import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void reset() async {
    try {
      await auth.sendPasswordResetEmail(email: emailC.text);
      Get.back();
      Get.snackbar(
          "BERHASIL", "Kami telah mengirim tautan untuk mengubah sandi");
    } catch (e) {
      Get.snackbar("BERHASIL",
          "Kami telah mengirim tautan untuk menyetel ulang sandi email Anda");
    }
  }
}
