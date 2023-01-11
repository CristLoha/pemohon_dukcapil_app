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

  ///SUAMI
  TextEditingController nikSuamiC = TextEditingController();
  TextEditingController namaLengkapSuamiC = TextEditingController();
  TextEditingController tanggalLahirSuamiC = TextEditingController();
  TextEditingController anakKeSuamiC = TextEditingController();
  TextEditingController tempatLahirSuamiC = TextEditingController();
  TextEditingController perkawinanKe = TextEditingController();
  TextEditingController kewarganegaraanSuamiC = TextEditingController();

  ///ISTRI
  TextEditingController nikIstriC = TextEditingController();
  TextEditingController namaLengkapIstriC = TextEditingController();
  TextEditingController tempatLahirIstriC = TextEditingController();
  TextEditingController anakKeIstriC = TextEditingController();
  TextEditingController tanggalLahirIstriC = TextEditingController();
  TextEditingController kewarganegaraanIstriC = TextEditingController();

  ///Orang Tua Dari Suami
  TextEditingController namaAyahDariSuami = TextEditingController();
  TextEditingController nikAyahDariSuami = TextEditingController();
  TextEditingController namaIbuDariSuami = TextEditingController();
  TextEditingController nikIbuDariSuami = TextEditingController();

  ///Orang Tua Dari Istri
  TextEditingController namaAyahDariIstri = TextEditingController();
  TextEditingController nikAyahDariIstri = TextEditingController();
  TextEditingController namaIbuDariIstri = TextEditingController();
  TextEditingController nikIbuDariIstri = TextEditingController();

  ///SAKSI SATU & DUA
  TextEditingController nikSaksi1 = TextEditingController();
  TextEditingController nikSaksi2 = TextEditingController();
  TextEditingController namaLengkapSaksi1 = TextEditingController();
  TextEditingController namaLengkapSaksi2 = TextEditingController();
  TextEditingController dateC = TextEditingController();

  /// PEMOHON
  TextEditingController namaPemohonC = TextEditingController();
  TextEditingController nikPemohon = TextEditingController();
  TextEditingController kecamatanPemohonC = TextEditingController();
  TextEditingController desaPemohonC = TextEditingController();
  TextEditingController emailPemohonC = TextEditingController();
  TextEditingController noTelponPemohonC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();

  int index = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
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

  final ImagePicker imagePickerAktaKelahiranIstri = ImagePicker();
  XFile? pickedImageAktaKelahiranIstri;

  final ImagePicker imagePickerKTPsaksi1 = ImagePicker();
  XFile? pickedImageKTPsaksi1;

  final ImagePicker imagePickerKTPsaksi2 = ImagePicker();
  XFile? pickedImageKTPsaksi2;

  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addAktaNikah() async {
    String uid = auth.currentUser!.uid;
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;

    if (pickedImageSelfie != null && pickedImageSuratNikah != null) {
      ///FOTO SELFIE
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

      /// PAS FOTO SUAMI ISTRI

      String extpasFotoSuamiIstri =
          pickedImagepasFotoSuamiIstri!.name.split(".").last;
      await storage
          .ref('Akta Nikah')
          .child('pasFotoSuamistri$randomNumber.$extpasFotoSuamiIstri')
          .putFile(
            File(pickedImagepasFotoSuamiIstri!.path),
          );

      String pasFotoSuamiIstri = await storage
          .ref('Akta Nikah')
          .child('pasFotoSuamistri$randomNumber.$extpasFotoSuamiIstri')
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
          .child('AktaKelahiranSuami$randomNumber.$extAktaKelahiranSuami')
          .getDownloadURL();

      /// AktaKelahiranIstri

      String extAktaKelahiranIstri =
          pickedImageAktaKelahiranIstri!.name.split(".").last;
      await storage
          .ref('Akta Nikah')
          .child('AktaKelahiranIstri$randomNumber.$extAktaKelahiranIstri')
          .putFile(
            File(pickedImageAktaKelahiranIstri!.path),
          );

      String aktaKelahiranIstri = await storage
          .ref('Akta Nikah')
          .child('AktaKelahiranIstri$randomNumber.$extAktaKelahiranIstri')
          .getDownloadURL();

      /// KTP SAKSI 1

      String extKTPsaksi1 = pickedImageKTPsaksi1!.name.split(".").last;
      await storage
          .ref('Akta Nikah')
          .child('KTPsaksi1$randomNumber.$extKTPsaksi1')
          .putFile(
            File(pickedImageKTPsaksi1!.path),
          );

      String ktpSaksi1 = await storage
          .ref('Akta Nikah')
          .child('KTPsaksi1$randomNumber.$extKTPsaksi1')
          .getDownloadURL();

      /// KTP SAKSI 2

      String extKTPSaksi2 = pickedImageKTPsaksi2!.name.split(".").last;
      await storage
          .ref('Akta Nikah')
          .child('KTPsaksi2$randomNumber.$extKTPSaksi2')
          .putFile(
            File(pickedImageKTPsaksi2!.path),
          );

      String ktpSaksi2 = await storage
          .ref('Akta Nikah')
          .child('KTPsaksi2$randomNumber.$extKTPSaksi2')
          .getDownloadURL();

      CollectionReference aktaNikah = firestore.collection('layanan');

      await aktaNikah.add({
        ///SUAMI
        'nikSuami': nikSuamiC.text,
        'namaLengkapSuami': namaLengkapSuamiC.text,
        'tanggalLahirSuami': tanggalLahirSuamiC.text,
        'tempatLahirSuami': tempatLahirSuamiC.text,
        'anakKeSuami': anakKeSuamiC.text,
        'kewarganegaraanSuami': kewarganegaraanSuamiC.text,

        ///ISTRI
        'nikIstri': nikIstriC.text,
        'namaLengkapIstri': namaLengkapIstriC.text,
        'tanggalLahirIstri': tanggalLahirIstriC.text,
        'anakKeIstri': anakKeIstriC.text,
        'kewarganegaraanIstri': kewarganegaraanIstriC.text,
        'tempatLahirIstri': tempatLahirIstriC.text,

        ///ORANG TUA SUAMI
        'namaAyahDariSuami': namaAyahDariSuami.text,
        'nikAyahDariSuami': nikAyahDariSuami.text,
        'nikIbuDariSuami': nikIbuDariSuami.text,
        'namaIbuDariSuami': namaIbuDariSuami.text,

        ///ORANG TUA ISTRI
        'namaAyahDariIstri': namaAyahDariIstri.text,
        'nikAyahDariIstri': nikAyahDariIstri.text,
        'nikIbuDariIstri': nikIbuDariIstri.text,
        'namaIbuDariIstri': namaIbuDariIstri.text,

        /// PEMOHON
        'nikPemohon': nikPemohon.text,
        'namaPemohon': namaPemohonC.text,
        'desaPemohon': desaPemohonC.text,
        'kecamatan': kecamatanPemohonC.text,
        'email': userPemohon!.email,
        'noTelponPemohon': noTelponPemohonC.text,
        'keyName': namaPemohonC.text.substring(0, 1).toUpperCase(),

        ///SAKSI 1 & 2
        'nikSaksi1': nikSaksi1.text,
        'nikSaksi2': nikSaksi2.text,
        'namaLengkapSaksi1': namaLengkapSaksi1.text,
        'namaLengkapSaksi2': namaLengkapSaksi2.text,

        ///PERSYARATAN
        'fotoSelfiePelapor': fotoSelfie,
        'fotoSuratNikah': fotoSuratNikah,
        'fotoSuketBelumNikah': fotoSuketBelumNikah,
        'fotoktpSuamiIstri': ktpSuamiIstri,
        'pasFotoSuamiIstri': pasFotoSuamiIstri,
        'fotoAktaKelahiranSuami': aktaKelahiranSuami,
        'fotoAktaKelahiranIstri': aktaKelahiranIstri,
        'fotoKTPsaksi1': ktpSaksi1,
        'fotoKTPsaksi2': ktpSaksi2,

        ///PROSES
        'kategori': 'Akta Nikah',
        'uid': uid,

        'keteranganKonfirmasi': '',
        'proses': 'PROSES VERIFIKASI',
        'creationTime': DateTime.now().toIso8601String(),
        'updatedTime': DateTime.now().toIso8601String(),
        // 'keterangan': keteranganC.text,
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
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageSelfie = dataImage;
        }
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
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageSuratNikah = dataImage;
        }
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
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageSuketBNikah = dataImage;
        }
      }
      update();
    } catch (err) {
      print(err);
      pickedImageSuketBNikah = null;
      update();
    }
  }

  ///KTP SUAMI ISTRI
  void selectImagektpSuamiIstri() async {
    try {
      final dataImage = await imagePickerKTPsuamiIstri.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageKTPsuamiIstri = dataImage;
        }
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

  ///pas foto
  void selectImagepasFotoSuamiIstri() async {
    try {
      final dataImage = await imagePickerPasFotoSuamiIstri.pickImage(
        source: ImageSource.gallery,
      );
      if (dataImage != null) {
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImagepasFotoSuamiIstri = dataImage;
        }
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
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageAktaKelahiranSuami = dataImage;
        }
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

  ///AKTA KELAHIRAN SUAMI
  void selectImageAktaKelahiranIstri() async {
    try {
      final dataImage = await imagePickerAktaKelahiranIstri.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageAktaKelahiranIstri = dataImage;
        }
      }
      update();
    } catch (err) {
      print(err);
      pickedImageAktaKelahiranIstri = null;
      update();
    }
  }

  void resetImageAktaKelahiranIstri() {
    pickedImageAktaKelahiranIstri = null;
    update();
  }

  //KTP SAKSI 1
  void selectImageKTPSaksi1() async {
    try {
      final dataImage = await imagePickerKTPsaksi1.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageKTPsaksi1 = dataImage;
        }
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKTPsaksi1 = null;
      update();
    }
  }

  void resetImageKTPsaksi1() {
    pickedImageKTPsaksi1 = null;
    update();
  }

  //KTP SAKSI 2
  void selectImageKTPSaksi2() async {
    try {
      final dataImage = await imagePickerKTPsaksi2.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageKTPsaksi2 = dataImage;
        }
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKTPsaksi2 = null;
      update();
    }
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
