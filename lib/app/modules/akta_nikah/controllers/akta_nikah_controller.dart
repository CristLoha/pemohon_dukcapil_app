import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/theme.dart';

class AktaNikahController extends GetxController {
  RxInt currentStep = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  TextEditingController nikSuamiC = TextEditingController();
  TextEditingController nikIstriC = TextEditingController();
  TextEditingController nikSaksi1 = TextEditingController();
  TextEditingController namaLengkapSaksi1 = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController nikSaksi2 = TextEditingController();
  TextEditingController noTelpC = TextEditingController();
  TextEditingController namaLengkapSaksi2 = TextEditingController();
  TextEditingController namaLengkapSuamiC = TextEditingController();
  TextEditingController namaLengkapIstriC = TextEditingController();
  TextEditingController tempatLahirSuamiC = TextEditingController();
  TextEditingController tempatLahirIstriC = TextEditingController();
  TextEditingController tanggalLahirSuamiC = TextEditingController();
  TextEditingController tanggalLahirIstriC = TextEditingController();
  TextEditingController kewarganegaraanSuamiC = TextEditingController();
  TextEditingController kewarganegaraanIstriC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();

  int index = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  List<Map<String, dynamic>> dataJenisKewarganegaraan = [
    {
      "jenisK": "WNI",
      "id": 1,
    },
    {
      "jenisK": "WNA",
      "id": 2,
    }
  ];

  final ImagePicker imagePickerSelfie = ImagePicker();
  XFile? pickedImageSelfie;

  final ImagePicker imagePickerSuratNikah = ImagePicker();
  XFile? pickedImageSuratNikah;

  final ImagePicker imagePickerSuketBNikah = ImagePicker();
  XFile? pickedImageSuketBNikah;

  final ImagePicker imagePickerKTPsuamiIstri = ImagePicker();
  XFile? pickedImageKTPsuamiIstri;

  final ImagePicker imagePickerPasFotoSuamiIstri = ImagePicker();
  XFile? pickedImagepasFotoSuamiIstri;

  final ImagePicker imagePickerAktaKelahiranSuami = ImagePicker();
  XFile? pickedImageAktaKelahiranSuami;

  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addrekamanKTP() async {
    String uid = auth.currentUser!.uid;
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;

    ///FOTO SELFIE
    if (pickedImageSelfie != null &&
        pickedImageSuratNikah != null &&
        pickedImageSuketBNikah != null &&
        pickedImageKTPsuamiIstri != null &&
        pickedImagepasFotoSuamiIstri != null &&
        pickedImageAktaKelahiranSuami != null) {
      String extFotoSelfie = pickedImageSelfie!.name.split(".").last;
      await storage
          .ref('Akta Nikah')
          .child('selfie$randomNumber.$extFotoSelfie')
          .putFile(
            File(pickedImageSelfie!.path),
          );

      String fotoSelfie = await storage
          .ref('Akta Nikah')
          .child('selfie$randomNumber.$extFotoSelfie')
          .getDownloadURL();

      /// SURAT NKAH

      String extSuratNikah = pickedImageSuratNikah!.name.split(".").last;
      await storage
          .ref('Akta Nikah')
          .child('suratNikah$randomNumber.$extSuratNikah')
          .putFile(
            File(pickedImageSuratNikah!.path),
          );

      String fotoSuratNikah = await storage
          .ref('Akta Nikah')
          .child('suratNikah$randomNumber.$extSuratNikah')
          .getDownloadURL();

      /// SUKET BELUM NIKAH

      String extSuketBelumNikah = pickedImageSuketBNikah!.name.split(".").last;
      await storage
          .ref('Akta Nikah')
          .child('suketBelumNikah$randomNumber.$extSuketBelumNikah')
          .putFile(
            File(pickedImageSuketBNikah!.path),
          );

      String fotoSuketBelumNikah = await storage
          .ref('Akta Nikah')
          .child('suketBelumNikah$randomNumber.$extSuketBelumNikah')
          .getDownloadURL();

      /// KTP SUAMI ISTRI

      String extktpSuamiIstri = pickedImageKTPsuamiIstri!.name.split(".").last;
      await storage
          .ref('Akta Nikah')
          .child('ktpSuamiIstri$randomNumber.$extktpSuamiIstri')
          .putFile(
            File(pickedImageKTPsuamiIstri!.path),
          );

      String ktpSuamiIstri = await storage
          .ref('Akta Nikah')
          .child('ktpSuamiIstri$randomNumber.$extktpSuamiIstri')
          .getDownloadURL();

      /// KTP SUAMI ISTRI

      String extpasFotoSuamiIstri =
          pickedImagepasFotoSuamiIstri!.name.split(".").last;
      await storage
          .ref('Akta Nikah')
          .child('pasFotoSuamiistri$randomNumber.$extpasFotoSuamiIstri')
          .putFile(
            File(pickedImagepasFotoSuamiIstri!.path),
          );

      String pasFotoSuamiIstri = await storage
          .ref('Akta Nikah')
          .child('pasFotoSuamiistri$randomNumber.$extpasFotoSuamiIstri')
          .getDownloadURL();

      /// AktaKelahiranSuami

      String extAktaKelahiranSuami =
          pickedImageAktaKelahiranSuami!.name.split(".").last;
      await storage
          .ref('Akta Nikah')
          .child('AktaKelahiranSuami$randomNumber.$extAktaKelahiranSuami')
          .putFile(
            File(pickedImageAktaKelahiranSuami!.path),
          );

      String aktaKelahiranSuami = await storage
          .ref('Akta Nikah')
          .child('aktaKelahiranSuami$randomNumber.$extAktaKelahiranSuami')
          .getDownloadURL();
      CollectionReference rekamanKtp = firestore.collection('layanan');

      await rekamanKtp.add({
        'nikSuami': nikSuamiC.text,
        'nikIstri': nikIstriC.text,
        'namaLengkapSuami': namaLengkapSuamiC.text,
        'tanggalLahirSuami': tanggalLahirSuamiC.text,
        'tanggalLahirIstri': tanggalLahirIstriC.text,
        'namaLengkapIstri': namaLengkapIstriC.text,
        'tempatLahirSuami': tempatLahirSuamiC.text,
        'tempatLahirIstri': tempatLahirIstriC.text,
        'email': emailC.text,
        'kewarganegaraanSuami': kewarganegaraanSuamiC.text,
        'kewarganegaranIstri': kewarganegaraanIstriC.text,
        'fotoSelfiePelapor': fotoSelfie,
        'fotoSuratNikah': fotoSuratNikah,
        'fotoSuketBelumNikah': fotoSuketBelumNikah,
        'fotoktpSuamiIstri': ktpSuamiIstri,
        'fotopasFotoSuamiIstri': pasFotoSuamiIstri,
        'fotoAktaKelahiranSuami': aktaKelahiranSuami,
        "keyName": namaLengkapSuamiC.text.substring(0, 1).toUpperCase(),
        'kategori': 'Akta Nikah',
        'uid': uid,
        'keterangan': keteranganC.text,
        'keteranganKonfirmasi': '',
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

  ///FOTO SELFIE
  void selectImageSelfie() async {
    try {
      final dataImage = await imagePickerSelfie.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageSelfie = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageSelfie = null;
      update();
    }
  }

  void resetImageSelfie() {
    pickedImageSelfie = null;
    update();
  }

  ///FOTO SURAT NIKAH
  void selectImageSuratNikah() async {
    try {
      final dataImage = await imagePickerSuratNikah.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageSuratNikah = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageSuratNikah = null;
      update();
    }
  }

  void resetImageSuratNikah() {
    pickedImageSuratNikah = null;
    update();
  }

  ///FOTO SUKET BELUM NIKAH
  void selectImageSuketBNikah() async {
    try {
      final dataImage = await imagePickerSuketBNikah.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageSuketBNikah = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageSuketBNikah = null;
      update();
    }
  }

  void resetImageSuketBnikah() {
    pickedImageSuketBNikah = null;
    update();
  }

  ///KTP SUAMI ISTRI
  void selectImagektpSuamiIstri() async {
    try {
      final dataImage = await imagePickerKTPsuamiIstri.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKTPsuamiIstri = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKTPsuamiIstri = null;
      update();
    }
  }

  void resetImagektpSuamiIstri() {
    pickedImageKTPsuamiIstri = null;
    update();
  }

  ///KTP SUAMI ISTRI
  void selectImagepasFotoSuamiIstri() async {
    try {
      final dataImage = await imagePickerPasFotoSuamiIstri.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImagepasFotoSuamiIstri = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImagepasFotoSuamiIstri = null;
      update();
    }
  }

  void resetImagektppasFotoSuamiIstri() {
    pickedImagepasFotoSuamiIstri = null;
    update();
  }

  ///AKTA KELAHIRAN SUAMI
  void selectImageAktaKelahiranSuami() async {
    try {
      final dataImage = await imagePickerAktaKelahiranSuami.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageAktaKelahiranSuami = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageAktaKelahiranSuami = null;
      update();
    }
  }

  void resetImageAktaKelahiranSuami() {
    pickedImageAktaKelahiranSuami = null;
    update();
  }

  void tglLahirSuami() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tanggalLahirSuamiC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  void tglLahirIstri() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tanggalLahirIstriC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  // Future<Map<String, dynamic>?> getProfile() async {
  //   try {
  //     String uid = auth.currentUser!.uid;
  //     DocumentSnapshot<Map<String, dynamic>> docUser =
  //         await firestore.collection("pemohon").doc(uid).get();

  //     return docUser.data();
  //   } catch (e) {
  //     print(e);
  //     Get.snackbar("TERJADI KESALAHAN", "Tidak dapat get data user.");
  //     return null;
  //   }
  // }

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
