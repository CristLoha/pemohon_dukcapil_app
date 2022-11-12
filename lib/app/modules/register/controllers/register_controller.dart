import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/data/models/pemohon_model.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  User? userPemohon = FirebaseAuth.instance.currentUser;
  Pemohon pemohonC = Pemohon();

  TextEditingController nikC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController noTelpC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxBool isHidden = false.obs;
  RxInt currentStep = 0.obs;
  RxBool isSelected = false.obs;
  RxString password = ''.obs;
  RxString displayText = ''.obs;

  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  void register() async {
    if (nameC.text.isNotEmpty &&
        nikC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        noTelpC.text.isNotEmpty &&
        passC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        CollectionReference pemohon = firestore.collection('pemohon');
        UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        print(credential);
        isLoading.value = false;
        if (credential.user!.emailVerified == false) {
          infoMsg('BERHASIL',
              'Kami telah mengirim email verifikasi. Buka email kamu untuk tahap verifikasi');

          Get.offAllNamed(Routes.LOGIN);
          await credential.user!.sendEmailVerification();
          await pemohon
              .doc(
                credential.user!.uid,
              )
              .set(
                ({
                  'nama': nameC.text,
                  'nik': nikC.text,
                  "keyName": nameC.text.substring(0, 1).toUpperCase(),
                  'email': emailC.text,
                  'nomor_telp': noTelpC.text,
                  'validasi': false,
                  'uid': credential.user!.uid,
                  "creationTime": DateTime.now().toIso8601String(),
                  "updatedTime": DateTime.now().toIso8601String(),
                }),
              );

          final curPemohon = await pemohon.doc(userPemohon!.uid).get();
          final curPemohonData = curPemohon.data() as Map<String, dynamic>;
          Pemohon(
              uid: curPemohonData['uid'],
              nama: curPemohonData['nama'],
              email: curPemohonData['email'],
              nik: curPemohonData['nik'],
              nomorTelp: curPemohonData['nomor_telp'],
              validasi: false,
              updatedTime: 'updated_time',
              creationTime: 'creation_time');
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          infoMsg('TERJADI KESALAHAN', 'Email sudah pernah digunakan');
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      infoMsg('TERJADI KESALAHAN', 'Semua data harus diisi');
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



