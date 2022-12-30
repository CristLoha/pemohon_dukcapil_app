import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/theme.dart';

class RegisAktaKematianController extends GetxController {
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

  /// JENAZAH
  TextEditingController nikJenazahC = TextEditingController();
  TextEditingController namaLengkapJenazahC = TextEditingController();
  TextEditingController jenisKelaminJenazahC = TextEditingController();
  TextEditingController tglLahirJenazahC = TextEditingController();
  TextEditingController tempatLahirC = TextEditingController();
  TextEditingController agamaJenazah = TextEditingController();
  TextEditingController anakKe = TextEditingController();
  TextEditingController pekerjaanJenazahC = TextEditingController();
  TextEditingController alamatJenazahC = TextEditingController();
  TextEditingController desaJenazahC = TextEditingController();
  TextEditingController kecamatanJenazahC = TextEditingController();
  TextEditingController kabupatenJenazahC = TextEditingController();
  TextEditingController provinsiJenazahC = TextEditingController();
  TextEditingController kodePosC = TextEditingController();
  TextEditingController tanggalKematianC = TextEditingController();
  TextEditingController pukulC = TextEditingController();
  TextEditingController sebabKematianC = TextEditingController();
  TextEditingController tempatKematianC = TextEditingController();
  TextEditingController menerangkanC = TextEditingController();

  /// PEMOHON
  TextEditingController nikPemohonC = TextEditingController();
  TextEditingController noTelepon = TextEditingController();
  TextEditingController namaLengkapPemohonC = TextEditingController();
  TextEditingController tanggalLahirPemohonC = TextEditingController();
  TextEditingController pekerjaanPemohonC = TextEditingController();
  TextEditingController alamatPemohon = TextEditingController();
  TextEditingController desaPemohon = TextEditingController();
  TextEditingController kecamatanPemohonC = TextEditingController();
  TextEditingController kabupatenPemohonC = TextEditingController();
  TextEditingController provinsiPemohonC = TextEditingController();

  /// SAKSI1
  TextEditingController nikSaksi1C = TextEditingController();
  TextEditingController namaLengkapSaksi1C = TextEditingController();
  TextEditingController tanggalLahirSaksi1C = TextEditingController();
  TextEditingController pekerjaanSaksi1C = TextEditingController();
  TextEditingController alamatSaksi1C = TextEditingController();
  TextEditingController desaSaksi1 = TextEditingController();
  TextEditingController kecamatanSaksi1C = TextEditingController();
  TextEditingController kabupatenSaksi1C = TextEditingController();
  TextEditingController provinsiSaksi1C = TextEditingController();

  /// SAKSI2
  TextEditingController nikSaksi2C = TextEditingController();
  TextEditingController namaLengkapSaksi2C = TextEditingController();
  TextEditingController tanggalLahirSaksi2C = TextEditingController();
  TextEditingController pekerjaanSaksi2C = TextEditingController();
  TextEditingController alamatSaksi2C = TextEditingController();
  TextEditingController desaSaksi2 = TextEditingController();
  TextEditingController kecamatanSaksi2C = TextEditingController();
  TextEditingController kabupatenSaksi2C = TextEditingController();
  TextEditingController provinsiSaksi2C = TextEditingController();
  int index = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
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

  List<Map<String, dynamic>> agama = [
    {
      "jenisAgama": "Islam",
      "id": 1,
    },
    {
      "jenisAgama": "Kristen",
      "id": 2,
    },
    {
      "jenisAgama": "Katolik",
      "id": 3,
    },
    {
      "jenisAgama": "Hindu",
      "id": 4,
    },
    {
      "jenisAgama": "Budha",
      "id": 5,
    },
    {
      "jenisAgama": "Lainnya",
      "id": 6,
    },
  ];

  List<Map<String, dynamic>> dataJenisYgMenerangkan = [
    {
      "menerangkan": "Dokter",
      "id": 1,
    },
    {
      "menerangkan": "Tenaga Kesehatan",
      "id": 2,
    },
    {
      "menerangkan": "Kepolisian",
      "id": 3,
    },
    {
      "menerangkan": "Lainnya",
      "id": 4,
    }
  ];

  List<Map<String, dynamic>> sebabKematian = [
    {
      "sKematian": "Sakit Biasa/tua",
      "id": 1,
    },
    {
      "sKematian": "Wabah Penyakit",
      "id": 2,
    },
    {
      "sKematian": "Kecelakaan",
      "id": 3,
    },
    {
      "sKematian": "Kriminalitas",
      "id": 4,
    },
    {
      "sKematian": "Bunuh Diri",
      "id": 5,
    },
    {
      "sKematian": "Lainnya",
      "id": 5,
    },
  ];

  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addPerubahanKTP() async {
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
          ///JENAZAH
          'nikJenazah': nikJenazahC.text,
          'namaLengkapJenazah': namaLengkapJenazahC.text,
          'jenisKelaminJenazah': jenisKelaminJenazahC.text,
          'tgl_lahirJenasah': tglLahirJenazahC.text,

          'tempatLahirJenazah': tempatLahirC.text,
          'agamaJenazah': agamaJenazah.text,
          'pekerjaanJenazah': pekerjaanJenazahC.text,
          'alamatJenazah': alamatJenazahC.text,
          'desaJenazah': desaJenazahC.text,
          'kecamatanJenazah': kecamatanJenazahC.text,
          'kabupatenJenazah': kecamatanJenazahC.text,
          'provinsiJenazah': provinsiJenazahC.text,
          'anakKe': anakKe.text,
          'tglKematian': tanggalKematianC.text,
          'pukul': pukulC.text,
          'sebabKematian': sebabKematianC.text,
          'tempatKematian': tempatKematianC.text,
          'yangMenerangkan': menerangkanC.text,

          ///SAKSI 1
          "nikSaksi1": nikSaksi1C.text,
          "namaLengkapSaksi1": namaLengkapSaksi1C.text,
          "tanggalLahirSaksi1": tanggalLahirSaksi1C.text,
          "pekerjaanSaksi1": pekerjaanSaksi1C.text,
          "alamatSaksi1": alamatSaksi1C.text,
          "desaSaksi1": desaSaksi1.text,
          "kecamatanSaksi1": kecamatanSaksi1C.text,
          "kabupatenSaksi1": kabupatenSaksi1C.text,
          "provinsiSaksi1": provinsiSaksi1C.text,

          ///SAKSI 2
          "nikSaksi2": nikSaksi2C.text,
          "namaLengkapSaksi2": namaLengkapSaksi2C.text,
          "tanggalLahirSaksi2": tanggalLahirSaksi2C.text,
          "pekerjaanSaksi2": pekerjaanSaksi2C.text,
          "alamatSaksi2": alamatSaksi2C.text,

          "desaSaksi2": desaSaksi2.text,
          "kecamatanSaksi2": kecamatanSaksi2C.text,
          "kabupatenSaksi2": kabupatenSaksi2C.text,
          "provinsiSaksi2": provinsiSaksi2C.text,

          ///PEMOHON
          "nikPemohon": nikPemohonC.text,
          "noTelpon": noTelepon.text,
          "namaLengkapPemohon": namaLengkapPemohonC.text,
          "tanggalLahirPemohon": tanggalLahirPemohonC.text,
          "pekerjaanPemohon": pekerjaanPemohonC.text,
          "alamatPemohon": alamatPemohon.text,
          "desaPemohon": desaPemohon.text,
          "kecamatanPemohon": kecamatanPemohonC.text,
          "kabupatenPemohon": kabupatenPemohonC.text,
          "provinsiPemohon": provinsiPemohonC.text,
          "kewarganegaraanPemohon": provinsiPemohonC.text,
          "email": userPemohon!.email,
          "keyName": namaLengkapPemohonC.text.substring(0, 1).toUpperCase(),

          ///PERSYARATAN
          'fotoKK': fotoKK,
          'fotoAktaKelahiran': fotoAktaKelahiran,
          'fotoKTPJenazah': ktpJenazah,
          'fotoKTPPelapor': ktpPelaPor,
          'fotoKKPelapor': fotoKKpelapor,

          ///PROSES
          'kategori': 'Akta Kematian',
          'uid': uid,
          'proses': 'PROSES VERIFIKASI',
          'keteranganKonfirmasi': '',
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

  //TANGGAL LAHIR JENAZAH
  void tglLahirJenazah() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tglLahirJenazahC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  ///tgl lahir pemohon
  void tglLahirPemohon() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tanggalLahirPemohonC.text =
            DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  ///tgl lahir saksi1
  void tglLahirSaksi1() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tanggalLahirSaksi1C.text =
            DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  ///tgl lahir saksi2
  void tglLahirSaksi2() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tanggalLahirSaksi2C.text =
            DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  ///TGL KEMATIAN
  void dateKematian() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tanggalKematianC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
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
