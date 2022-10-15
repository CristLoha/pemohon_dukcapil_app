import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  Timer? timer;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isHidden = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSelected = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  void login() async {
    try {
      isLoading.value = true;
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );

      print(credential);
      isLoading.value = false;
      Get.offAllNamed(Routes.MAIN_PAGE);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      print(e.code);
    }
  }
}
