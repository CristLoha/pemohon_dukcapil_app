import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

import '../../../routes/app_pages.dart';

class AktaPerceraianController extends GetxController {
  RxInt currentStep = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  TextEditingController nikC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController noTelpC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();

  int index = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  XFile? pickedImageKK;
  final ImagePicker imagePickerKK = ImagePicker();

  XFile? pickedImageKtpSuamiIstri;
  final ImagePicker imagePickerKtpSuamiIstri = ImagePicker();

  XFile? pickedImageAktaPernikahan;
  final ImagePicker imagePickerAktaPernikahan = ImagePicker();

  XFile? pickedImageSuketPanitera;
  final ImagePicker imagePickerSuketPanitera = ImagePicker();

  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addAktaPerceraian() async {
    String uid = auth.currentUser!.uid;
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;
    if (pickedImageKtpSuamiIstri != null) {
      ///KTP SUAMI ISTRI
      String extKTPsuamiIstri = pickedImageKtpSuamiIstri!.name.split(".").last;
      await storage
          .ref('Akta Perceraian')
          .child('KTPsuamiIstri$randomNumber.$extKTPsuamiIstri')
          .putFile(
            File(pickedImageKtpSuamiIstri!.path),
          );

      String fotoKTPsuamiIstri = await storage
          .ref('Akta Perceraian')
          .child('KTPsuamiIstri$randomNumber.$extKTPsuamiIstri')
          .getDownloadURL();

      ///KK
      String extKK = pickedImageKK!.name.split(".").last;
      await storage
          .ref('Akta Perceraian')
          .child('KK$randomNumber.$extKTPsuamiIstri')
          .putFile(
            File(pickedImageKtpSuamiIstri!.path),
          );

      String fotoKK = await storage
          .ref('Akta Perceraian')
          .child('KK$randomNumber.$extKK')
          .getDownloadURL();

      ///AKTA PERNIKAHAN
      String extAktaPernikahan =
          pickedImageAktaPernikahan!.name.split(".").last;
      await storage
          .ref('Akta Perceraian')
          .child('AktaPernikahan$randomNumber.$extAktaPernikahan')
          .putFile(
            File(pickedImageAktaPernikahan!.path),
          );

      String fotoAktaPernikahan = await storage
          .ref('Akta Perceraian')
          .child('AktaPernikahan$randomNumber.$extKK')
          .getDownloadURL();

      //// SUKET Panitera Pengadilan Negeri
      String extSUKETpanitera = pickedImageSuketPanitera!.name.split(".").last;
      await storage
          .ref('Akta Perceraian')
          .child('SuketPanitera$randomNumber.$extSUKETpanitera')
          .putFile(
            File(pickedImageSuketPanitera!.path),
          );

      String fotoSuketPanitera = await storage
          .ref('Akta Perceraian')
          .child('SuketPanitera$randomNumber.$extSUKETpanitera')
          .getDownloadURL();

      CollectionReference rekamanKtp = firestore.collection('layanan');

      await rekamanKtp.add({
        /// PEMOHON
        'nik': nikC.text,
        'nama': nameC.text,
        'tgl_lahir': dateC.text,
        "keyName": nameC.text.substring(0, 1).toUpperCase(),
        'kecamatan': kecamatanC.text,
        'email': emailC.text,
        'noTelpon': noTelpC.text,
        'desa': desaC.text,

        ///PERSYARATAN
        'fotoKTPsuamiIstri': fotoKTPsuamiIstri,
        'fotoKK': fotoKK,
        'aktaPernikahan': fotoAktaPernikahan,
        'suketPanitera': fotoSuketPanitera,

        ///PROSES
        'uid': uid,
        'keterangan': keteranganC.text,
        'keteranganKonfirmasi': '',
        'proses': 'PROSES VERIFIKASI',
        'kategori': 'Akta Perceraian',
        'creationTime': DateTime.now().toIso8601String(),
        'updatedTime': DateTime.now().toIso8601String(),
      }).then(
        (value) {
          EasyLoading.showSuccess('Data Berhasil Ditambahakan');
          Get.offAllNamed(Routes.MAIN_PAGE);
        },
      ).catchError(
        (error) {
          print("Failed to add user: $error");
        },
      );
    } else {
      EasyLoading.showError(
        'Masukan file persyaratan terlebihi dahulu',
      );
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

  /// KTP SUAMI ISTRI
  void selectImageKtpSuamiIstri() async {
    try {
      final dataImage = await imagePickerKtpSuamiIstri.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKtpSuamiIstri = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKtpSuamiIstri = null;
      update();
    }
  }

  void resetImageKtpSuamiIstri() {
    pickedImageKK = null;
    update();
  }

  /// KK
  void selectImageKK() async {
    try {
      final dataImage = await imagePickerKK.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKK = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKK = null;
      update();
    }
  }

  void resetImageKK() {
    pickedImageKK = null;
    update();
  }

  ///AKTA PERNIKAHAN
  void selectImageAktaPerkawinan() async {
    try {
      final dataImage = await imagePickerAktaPernikahan.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageAktaPernikahan = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageAktaPernikahan = null;
      update();
    }
  }

  void resetImageAktaPerkawinan() {
    pickedImageAktaPernikahan = null;
    update();
  }

  ///SUKET PANITERA
  void selectImageSuketPanitera() async {
    try {
      final dataImage = await imagePickerSuketPanitera.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageSuketPanitera = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageSuketPanitera = null;
      update();
    }
  }

  void resetImageSuketPanitera() {
    pickedImageSuketPanitera = null;
    update();
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

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docUser =
          await firestore.collection("pemohon").doc(uid).get();

      return docUser.data();
    } catch (e) {
      print(e);
      Get.snackbar("TERJADI KESALAHAN", "Tidak dapat get data user.");
      return null;
    }
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
