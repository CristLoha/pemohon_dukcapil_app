import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isHidden = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nikC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController jenisKelaminC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController noTelpC = TextEditingController();
  TextEditingController passC = TextEditingController();

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docUser =
          await firestore.collection('pemohon').doc(uid).get();

      return docUser.data();
    } catch (e) {
      Get.snackbar('TERJADI KESALAHAN', 'Tidak dapat menggambil data');
    }
    return null;
  }

  void updateProfile() async {
    try {
      String uid = auth.currentUser!.uid;

      await firestore.collection('pemohon').doc(uid).update({
        'nama': nameC.text,
        'nik': nikC.text,
        'jenisKelamin': jenisKelaminC.text,
        'nomor_telp': noTelpC.text,
      });

      if (passC.text.isNotEmpty) {
        ///UPDATE PASS
        await auth.currentUser!.updatePassword(passC.text);
        await auth.signOut();
        Get.offAllNamed(Routes.LOGIN);
      }
    } catch (e) {
      Get.snackbar('TERJADI KESALAHAN', 'Tidak dapat menggambil data');
    }
    return null;
  }
}
