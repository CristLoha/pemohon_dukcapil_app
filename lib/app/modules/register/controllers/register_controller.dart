import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController nikC = TextEditingController();
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController noTelpC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxBool isHidden = false.obs;
  RxInt currentStep = 0.obs;
  RxBool isSelected = false.obs;
  RxString password = ''.obs;
  RxString displayText = ''.obs;
  var passwordStrength = 0.0.obs;
  RegExp numRegExpress = RegExp(r".*[0-9].*");
  RegExp letterRegExpress = RegExp(r".*[A-Za-z].*");

  void checkPasswordStregth(String value) {
    password.value = value.trim();
    if (password.value.isEmpty) {
      passwordStrength.value = 0.0;
      displayText.value = "";
    } else if (password.value.length < 6) {
      passwordStrength.value = 1 / 4;
      displayText.value = "Terlalu pendek";
    } else if (password.value.length < 8) {
      passwordStrength.value = 2 / 4;
      displayText.value = "Lemah";
    } else {
      if (!letterRegExpress.hasMatch(password.value) ||
          !numRegExpress.hasMatch(password.value)) {
        passwordStrength.value = 3 / 4;
        displayText.value = "Kuat";
      } else {
        passwordStrength.value = 1;
        displayText.value = "Sangat kuat";
      }
    }
  }
}
