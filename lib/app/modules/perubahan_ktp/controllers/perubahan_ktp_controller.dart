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

import '../../../routes/app_pages.dart';
import '../../../shared/theme.dart';

class PerubahanKtpController extends GetxController {
  RxInt currentStep = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final ImagePicker imagePickerKK = ImagePicker();
  XFile? pickedImageKK;

  final ImagePicker imagePickerKTP = ImagePicker();
  XFile? pickedImageKTP;

  final ImagePicker imagePickerSURKER = ImagePicker();
  XFile? pickedImageSURKER;
  TextEditingController nikC = TextEditingController();
  TextEditingController noKKC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController desaC = TextEditingController();

  int index = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addPerubahanKTP() async {
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;
    if (pickedImageKK != null && pickedImageKTP != null) {
      // FOTO KK
      String extKK = pickedImageKK!.name.split(".").last;

      await storage
          .ref('perubahanKTP')
          .child('perKTP_KK$randomNumber.$extKK')
          .putFile(
            File(pickedImageKK!.path),
          );

      String fotoKK = await storage
          .ref('perubahanKTP')
          .child('perKTP_KK$randomNumber.$extKK')
          .getDownloadURL();

      /// FOTO KTP
      String extKTP = pickedImageKTP!.name.split(".").last;

      await storage
          .ref('perubahanKTP')
          .child('perKTP_KTP$randomNumber.$extKTP')
          .putFile(
            File(pickedImageKTP!.path),
          );

      String fotoKTP = await storage
          .ref('perubahanKTP')
          .child('perKTP_KTP$randomNumber.$extKTP')
          .getDownloadURL();

      CollectionReference rekamanKtp = firestore.collection('layanan');
      try {
        String uid = auth.currentUser!.uid;

        await rekamanKtp.add({
          'nik': nikC.text,
          'nama': nameC.text,
          'noKK': noKKC.text,
          'fotoKK': fotoKK,
          'keterangan': '',
          'fotoKTP': fotoKTP,
          'tgl_lahir': dateC.text,
          "keyName": nameC.text.substring(0, 1).toUpperCase(),
          'kategori': 'Perubahan e-KTP',
          'kecamatan': kecamatanC.text,
          'email': userPemohon!.email,
          'desa': desaC.text,
          'uid': uid,
          'proses': 'PROSES VERIFIKASI',
          'creationTime': DateTime.now().toIso8601String(),
          'updatedTime': DateTime.now().toIso8601String(),
        });
        EasyLoading.showSuccess('Data Berhasil Ditambahakan');

        Get.offAllNamed(Routes.MAIN_PAGE);

        Get.back();
      } catch (e) {
        print(e);
      }
    } else {
      EasyLoading.showError(
        'Masukan file terlebihi dahulu',
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

  void resetImageKK() {
    pickedImageKK = null;
    update();
  }

  void resetImageKTP() {
    pickedImageKTP = null;
    update();
  }

  void resetImageSURKER() {
    pickedImageSURKER = null;
    update();
  }

  /// FOTO KK
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

  /// FOTO KTP
  void selectImageKTP() async {
    try {
      final dataImage = await imagePickerKTP.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKTP = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKTP = null;
      update();
    }
  }

  // /// FOTO SURAT KETERANGAN HILANG
  // void selectImageSurket() async {
  //   try {
  //     final dataImage = await imagePickerSURKER.pickImage(
  //       source: ImageSource.gallery,
  //     );

  //     if (dataImage != null) {
  //       print(dataImage.name);
  //       print(dataImage.path);
  //       pickedImageSURKER = dataImage;
  //     }
  //     update();
  //   } catch (err) {
  //     print(err);
  //     pickedImageKTP = null;
  //     update();
  //   }
  // }

  ///UNTUK FORM TANGGAL
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
}
