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

class RegistKiaController extends GetxController {
  RxInt currentStep = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final ImagePicker imagePickerKTPJenazah = ImagePicker();
  XFile? pickedImageKTPJenazah;

  final ImagePicker imagePickerKK = ImagePicker();
  XFile? pickedImageKK;

  final ImagePicker imagePickerAktaKelahiran = ImagePicker();
  XFile? pickedImageAktaKelahiran;

  final ImagePicker imagePickerKTPPelapor = ImagePicker();
  XFile? pickedImageKtpPelapor;

  final ImagePicker imagePickerKKPelapor = ImagePicker();
  XFile? pickedImageKKPelapor;

  ///KIA
  TextEditingController nikAnakC = TextEditingController();
  TextEditingController noAktaKelahiranC = TextEditingController();
  TextEditingController namaLengkapC = TextEditingController();
  TextEditingController jenisKelaminC = TextEditingController();
  TextEditingController tglLahirC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();

  TextEditingController nikPemohonC = TextEditingController();
  TextEditingController namaLengkapPemohonC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController kecamatanPemohonC = TextEditingController();
  TextEditingController desaPemohonC = TextEditingController();

  int index = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  List<Map<String, dynamic>> dataJenisKelamin = [
    {
      "jenisKelamin": "LAKI-LAKI",
      "id": 1,
    },
    {
      "jenisKelamin": "PEREMPUAN",
      "id": 2,
    }
  ];

  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addKIA() async {
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;
    if (pickedImageKTPJenazah != null &&
        pickedImageAktaKelahiran != null &&
        pickedImageKtpPelapor != null) {
      /// KTP Jenazah
      String extKTPJenazah = pickedImageKTPJenazah!.name.split(".").last;

      await storage
          .ref('aktaKematian')
          .child('KTPJenazah$randomNumber.$extKTPJenazah')
          .putFile(
            File(pickedImageKTPJenazah!.path),
          );

      String ktpJenazah = await storage
          .ref('aktaKematian')
          .child('KTPJenazah$randomNumber.$extKTPJenazah')
          .getDownloadURL();

      /// KK
      String extKK = pickedImageKK!.name.split(".").last;

      await storage.ref('aktaKematian').child('KK$randomNumber.$extKK').putFile(
            File(pickedImageKK!.path),
          );

      String fotoKK = await storage
          .ref('aktaKematian')
          .child('KK$randomNumber.$extKK')
          .getDownloadURL();

      /// AKTAkelahiran
      String extAktaKelahiran = pickedImageAktaKelahiran!.name.split(".").last;

      await storage
          .ref('aktaKematian')
          .child('AktaKelahiran$randomNumber.$extAktaKelahiran')
          .putFile(
            File(pickedImageAktaKelahiran!.path),
          );

      String fotoAktaKelahiran = await storage
          .ref('aktaKematian')
          .child('AktaKelahiran$randomNumber.$extKK')
          .getDownloadURL();

      /// KTP Pelapor
      String extKtPPelapor = pickedImageKtpPelapor!.name.split(".").last;

      await storage
          .ref('aktaKematian')
          .child('KtpPelapor$randomNumber.$extKtPPelapor')
          .putFile(
            File(pickedImageKtpPelapor!.path),
          );

      String ktpPelaPor = await storage
          .ref('aktaKematian')
          .child('KtpPelapor$randomNumber.$extKtPPelapor')
          .getDownloadURL();

      /// KKPelapor
      String extKKpelapor = pickedImageKKPelapor!.name.split(".").last;

      await storage
          .ref('aktaKematian')
          .child('KKpelapor$randomNumber.$extKKpelapor')
          .putFile(
            File(pickedImageKKPelapor!.path),
          );

      String fotoKKpelapor = await storage
          .ref('aktaKematian')
          .child('KKpelapor$randomNumber.$extKKpelapor')
          .getDownloadURL();

      try {
        String uid = auth.currentUser!.uid;
        CollectionReference rekamanKtp = firestore.collection('layanan');
        await rekamanKtp.add({
          'nikAnak': nikAnakC.text,
          'namaLengkap': namaLengkapC.text,
          'kecamatan': kecamatanC.text,
          'kecamatanPemohon': kecamatanPemohonC.text,
          'desaPemohon': desaPemohonC.text,
          'noAktaKelahiran': noAktaKelahiranC.text,
          'nikPemohon': nikPemohonC.text,
          'namaLengkapPemohon': namaLengkapC,
          'jenisKelamin': jenisKelaminC.text,
          'tgl_lahir': tglLahirC.text,
          'keterangan': keteranganC.text,
          'desa': desaC.text,
          "keyName": namaLengkapC.text.substring(0, 1).toUpperCase(),
          'kategori': 'KIA',
          'email': userPemohon!.email,
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

  /// FOTO KTP JENAZAH
  void selectImageKTPJenazah() async {
    try {
      final dataImage = await imagePickerKTPJenazah.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKTPJenazah = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKTPJenazah = null;
      update();
    }
  }

  void resetImageKTPJenazah() {
    pickedImageKTPJenazah = null;
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

  void resetImageKK() {
    pickedImageKK = null;
    update();
  }

  ///AKTA KELAHIRAN

  void selectImageAktaKelahiran() async {
    try {
      final dataImage = await imagePickerAktaKelahiran.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageAktaKelahiran = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageAktaKelahiran = null;
      update();
    }
  }

  void resetImageAktaKelahiran() {
    pickedImageAktaKelahiran = null;
    update();
  }

  /// KTP PELAPOR
  void selectKtpPelapor() async {
    try {
      final dataImage = await imagePickerKTPPelapor.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKtpPelapor = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKtpPelapor = null;
      update();
    }
  }

  void resetImageKtpPelapor() {
    pickedImageKtpPelapor = null;
    update();
  }

  /// KK PELAPOR

  void selectKKPelapor() async {
    try {
      final dataImage = await imagePickerKKPelapor.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKKPelapor = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKKPelapor = null;
      update();
    }
  }

  void resetImageKKPelapor() {
    pickedImageKKPelapor = null;
    update();
  }

  ///UNTUK FORM TANGGAL
  void dateLocal() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tglLahirC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
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
