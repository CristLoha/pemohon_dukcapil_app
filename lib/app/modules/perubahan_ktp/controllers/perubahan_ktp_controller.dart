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
  final ImagePicker imagePicker = ImagePicker();
  TextEditingController nikC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController desaC = TextEditingController();

  XFile? pickedImage;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addPerubahanKTP() async {
    String uid = auth.currentUser!.uid;
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;
    if (pickedImage != null) {
      String ext = pickedImage!.name.split(".").last;
      await storage
          .ref('perubahanKTP')
          .child('perKTP$randomNumber.$ext')
          .putFile(
            File(pickedImage!.path),
          );

      String fotoKK = await storage
          .ref('perubahanKTP')
          .child('perKTP$randomNumber.$ext')
          .getDownloadURL();

      if (nikC.text.isNotEmpty &&
          nameC.text.isNotEmpty &&
          dateC.text.isNotEmpty &&
          kecamatanC.text.isNotEmpty &&
          desaC.text.isNotEmpty) {
        CollectionReference rekamanKtp = firestore.collection('layanan');

        await rekamanKtp.add({
          'nik': nikC.text,
          'nama': nameC.text,
          'fotoKK': fotoKK,
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
        EasyLoading.showError('Data tidak boleh kosong');
        print('data tidak boleh kosong');
      }
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

  void resetImage() {
    pickedImage = null;
    update();
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

  void uploadImage() async {
    s.Reference storageRef = storage.ref("perubahanKTP/kk.jpg");
    File file = File(pickedImage!.path);
    try {
      final dataUpload = await storageRef.putFile(file);
      print(dataUpload);
    } catch (e) {
      print('err');
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
}
