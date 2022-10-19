import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

class RekamananKtpController extends GetxController {
  RxInt currentStep = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final ImagePicker imagePicker = ImagePicker();
  TextEditingController nikC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController desaC = TextEditingController();

  XFile? pickedImage;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void resetImage() {
    pickedImage = null;
    update();
  }

  void addrekamanKTP() async {
    if (nikC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        dateC.text.isNotEmpty &&
        kecamatanC.text.isNotEmpty &&
        desaC.text.isNotEmpty) {
      String uid = auth.currentUser!.uid;

      ///COLLECTION 2
      try {
        await firestore.collection('pemohon').doc(uid).collection('ktp').add({
          'nik': nikC.text,
          'nama': nameC.text,
          'tgl_lahir': dateC.text,
          'kecamatan': kecamatanC.text,
          'desa': desaC.text,
          'uid': uid,
          'proses': 'PROSES VERIFIKASI',
          'createdAt': DateTime.now().toIso8601String(),
        });

        await firestore.collection('ktp').add({
          'nik': nikC.text,
          'nama': nameC.text,
          'tgl_lahir': dateC.text,
          'kecamatan': kecamatanC.text,
          'desa': desaC.text,
          'uid': uid,
          'proses': 'PROSES VERIFIKASI',
          'createdAt': DateTime.now().toIso8601String(),
        }).then(
          (value) {
            EasyLoading.showSuccess('Data Berhasil Ditambahakan');

            Get.offNamed(Routes.MAIN_PAGE);
          },
        ).catchError(
          (error) {
            print("Failed to add user: $error");
          },
        );
      } catch (e) {
        print('bla bla');
      }
    } else {
      EasyLoading.showError('Data tidak boleh kosong');
      print('data tidak boleh kosong');
    }
  }

  void uploadImage() async {
    Reference storageRef = storage.ref("rekamanKTP/kk.png");
    File file = File(pickedImage!.path);
    try {
      final dataUpload = await storageRef.putFile(file);
      print(dataUpload);
    } catch (e) {
      print('err');
    }
  }

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

  void selectImage() async {
    try {
      final dataImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImage = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImage = null;
      update();
    }
  }

  ///UNTUK FORM
  void dateLocal() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime(2006, 12, 31),
    ).then((selectedDate) {
      if (selectedDate != null) {
        dateC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  ///JENIS KALENDER
  // void date() async {
  //   await showDatePicker(
  //     context: Get.context!,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime.now(),
  //   ).then((selectedDate) {
  //     if (selectedDate != null) {
  //       dateC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  //     }
  //   });
  // }

  ///UNTUK MENAMPILKAN DI TEXT BIASA
  // void chooseDate() async {
  //   DateTime? picketDate = await showDatePicker(
  //     context: Get.context!,
  //     initialDate: selectedDate.value,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2023),
  //   );
  //   if (picketDate != null && picketDate != selectedDate.value) {
  //     selectedDate.value = picketDate;
  //   }
  // }
}
