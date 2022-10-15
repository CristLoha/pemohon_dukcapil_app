import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController nikC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController noTelpC = TextEditingController();
  TextEditingController passC = TextEditingController();

  final formKey = GlobalKey<FormState>();
  RxBool isHidden = false.obs;
  RxInt currentStep = 0.obs;
  RxBool isSelected = false.obs;
  RxString password = ''.obs;
  RxString displayText = ''.obs;

  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  void register() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        print(credential);
        isLoading.value = false;

        Get.offAllNamed(Routes.MAIN_PAGE);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
            'Peringatan',
            'Email sudah pernah digunakan ',
            backgroundColor: kBlackColor,
            colorText: kWhiteColor,
            snackPosition: SnackPosition.TOP,
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}

  // var passwordStrength = 0.0.obs;
  // RegExp numRegExpress = RegExp(r".*[0-9].*");
  // RegExp letterRegExpress = RegExp(r".*[A-Za-z].*");

  // void checkPasswordStregth(String value) {
  //   password.value = value.trim();
  //   if (password.value.isEmpty) {
  //     passwordStrength.value = 0.0;
  //     displayText.value = "";
  //   } else if (password.value.length < 6) {
  //     passwordStrength.value = 1 / 4;
  //     displayText.value = "Terlalu pendek";
  //   } else if (password.value.length < 8) {
  //     passwordStrength.value = 2 / 4;
  //     displayText.value = "Lemah";
  //   } else {
  //     if (!letterRegExpress.hasMatch(password.value) ||
  //         !numRegExpress.hasMatch(password.value)) {
  //       passwordStrength.value = 3 / 4;
  //       displayText.value = "Kuat";
  //     } else {
  //       passwordStrength.value = 1;
  //       displayText.value = "Sangat kuat";
  //     }
  //   }
  // }



